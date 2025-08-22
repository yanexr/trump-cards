import asyncio
import json
import argparse
import websockets

games = {}
counter = '0000'


def generate_new_id():
    """
    Returns an incremented 4 digit number as a string.
    """
    global counter
    if counter < '9999':
        counter = str(int(counter) + 1).zfill(4)
        return counter
    else:
        counter = '0000'
        return counter


def get_game_code(websocket):
    """
    Returns the game code for the game that the user is in.
    """
    for game_code, game in games.items():
        for _, socket in game['users']:
            if socket == websocket:
                return game_code
    return None


def remove_user(websocket):
    """
    Removes the user from the game that they are in and closes the
    game if there are no more users.
    """
    game_code = get_game_code(websocket)
    if game_code is None:
        return

    for index, user in enumerate(games[game_code]['users']):
        if user[1] == websocket:
            del games[game_code]['users'][index]
            if len(games[game_code]['users']) == 0:
                del games[game_code]
            break


async def create_game(websocket, message):
    """
    Handles the "createGame" message:
    {
      "type": "createGame",
      "username": "<string>"
    }
    """
    username = message.get("username")
    if not username:
        raise ValueError("Username is required.")

    new_game_id = generate_new_id()

    games[new_game_id] = {
        'users': [(username, websocket)],
        'has_started': False
    }

    response = {
        "type": "createGameSuccess",
        "gameCode": new_game_id
    }
    await websocket.send(json.dumps(response))


async def join_game(websocket, message):
    """
    Handles the "joinGame" message:
    {
      "type": "joinGame",
      "gameCode": "<string>",
      "username": "<string>"
    }
    """
    game_code = message.get("gameCode")
    username = message.get("username")

    if not game_code or not username:
        raise ValueError("Game code and username are required.")

    if game_code not in games:
        raise ValueError("Game does not exist.")

    if len(games[game_code]['users']) >= 4:
        raise ValueError("Game is already full.")

    if games[game_code]['has_started']:
        raise ValueError("Game has already started.")

    if username in [name for name, _ in games[game_code]['users']]:
        raise ValueError("Username is already taken.")

    # Add the user
    games[game_code]['users'].append((username, websocket))

    # Send back a success message listing all current usernames
    usernames = [name for name, _ in games[game_code]['users']]
    join_success = {
        "type": "joinGameSuccess",
        "usernames": usernames
    }
    await websocket.send(json.dumps(join_success))

    # Notify others in the game that a new user joined
    broadcast = {
        "type": "newUserJoined",
        "username": username
    }
    for _, sock in games[game_code]['users']:
        if sock != websocket:
            await sock.send(json.dumps(broadcast))


async def start_game(websocket, message):
    """
    Handles the "startGame" message:
    {
      "type": "startGame",
      "cardIds": [ [<int>, <int>, ...], [<int>, <int>, ...], ... ],
      "cardDeckJson": "<string>"
    }
    """
    game_code = get_game_code(websocket)
    if game_code is None:
        raise ValueError("Game code not found.")

    card_ids_per_player = message.get("cardIds")
    card_deck_json = message.get("cardDeckJson", "")

    if not card_ids_per_player:
        raise ValueError("Missing cardIds field.")

    if len(card_ids_per_player) < len(games[game_code]['users']):
        raise ValueError("Not enough card ID lists for all users.")

    # Mark the game as started
    games[game_code]['has_started'] = True

    # Send each user their subset of card IDs (plus the deck JSON)
    for idx, (username, sock) in enumerate(games[game_code]['users']):
        start_game_success = {
            "type": "startGameSuccess",
            "cardIds": card_ids_per_player[idx],
            "cardDeckJson": card_deck_json
        }
        await sock.send(json.dumps(start_game_success))


async def send_card(websocket, message):
    """
    Handles the "sendCard" message:
    {
      "type": "sendCard",
      "cardId": <int>,
      "fromUsername": "<string>",
      "toUsername": "<string>"
    }
    """
    game_code = get_game_code(websocket)
    if game_code is None:
        raise ValueError("Game code not found.")

    card_id = message.get("cardId")
    from_username = message.get("fromUsername")
    to_username = message.get("toUsername")

    if card_id is None or not from_username or not to_username:
        raise ValueError("Invalid sendCard parameters.")

    # Broadcast "sendCardSuccess" to all players
    broadcast = {
        "type": "sendCardSuccess",
        "cardId": card_id,
        "fromUsername": from_username,
        "toUsername": to_username
    }
    # Send to everyone; tolerate disconnected sockets
    stale_indexes = []
    for idx, (_, sock) in enumerate(games[game_code]['users']):
        try:
            await sock.send(json.dumps(broadcast))
        except Exception:
            stale_indexes.append(idx)
    # Clean up any stale sockets
    for idx in reversed(stale_indexes):
        try:
            del games[game_code]['users'][idx]
        except Exception:
            pass


async def handle_connection(websocket):
    """
    Handles incoming messages from a client via WebSocket.
    """
    # First message should be either createGame or joinGame
    try:
        data_text = await websocket.recv()
        data = json.loads(data_text)

        msg_type = data.get("type")
        if msg_type == "createGame":
            await create_game(websocket, data)
        elif msg_type == "joinGame":
            await join_game(websocket, data)
        else:
            raise ValueError("Invalid command for first message.")
    except (ValueError, KeyError, json.JSONDecodeError) as e:
        error_resp = {
            "type": "error",
            "failureReason": str(e)
        }
        await websocket.send(json.dumps(error_resp))
        return

    # Once in a game, keep listening for further commands
    while True:
        try:
            data_text = await websocket.recv()
            data = json.loads(data_text)

            msg_type = data.get("type")
            if msg_type == "startGame":
                await start_game(websocket, data)
            elif msg_type == "sendCard":
                await send_card(websocket, data)
            else:
                raise ValueError("Invalid command.")

        except (ValueError, KeyError, json.JSONDecodeError) as e:
            # Send error back
            error_resp = {
                "type": "error",
                "failureReason": str(e)
            }
            await websocket.send(json.dumps(error_resp))
            break
        except websockets.exceptions.ConnectionClosedOK:
            remove_user(websocket)
            break
        except websockets.exceptions.ConnectionClosedError:
            remove_user(websocket)
            break
        except websockets.exceptions.ConnectionClosed:
            remove_user(websocket)
            break


def _resolve_host_port():
    """Parse CLI args only; defaults: host=localhost, port=8000."""
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument("--host", dest="host", default="localhost")
    parser.add_argument("--port", dest="port", type=int, default=8000)
    args, _ = parser.parse_known_args()
    return args.host, args.port


async def main():
    host, port = _resolve_host_port()

    async with websockets.serve(
        handle_connection,
        host,
        port,
        ping_interval=30,
        ping_timeout=30,
    ):
        print(f"Server started on {host}:{port}...")
        await asyncio.Future()  # run forever


if __name__ == "__main__":
    asyncio.run(main())

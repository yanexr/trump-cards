# Trump Cards – Server

This document describes the (optional) server for the *Trump Cards* game.

## Run the Code
First, make sure you have Python 3 and the `websockets>=14.1` library installed.
To start the server, run the following command in the `server` directory:
```bash
python server.py
```
By default, the server will run on `localhost` at port `8000`. In the client, you can change the server address in [`client/lib/game/network.dart`](https://github.com/yanexr/trump-cards/blob/main/client/lib/game/network.dart), e.g., `ws://localhost:8000`.



## Network Protocol
Each message is a JSON object (UTF-8 encoded) with a `type` field indicating the message type. Below are the message types, their structures, and brief explanations.

### 1. Create Game
**Direction**: Client → Server  
```json
{  
  "type": "createGame",  
  "username": "<string>"  
}
```
**Purpose**: Request server to create a new game.  

---

### 2. Create Game Success
**Direction**: Server → Client  
```json
{  
  "type": "createGameSuccess",  
  "gameCode": "<string>"  
}
```
**Purpose**: Confirms the game was created, providing the unique `gameCode`.

---

### 3. Join Game
**Direction**: Client → Server  
```json
{  
  "type": "joinGame",  
  "gameCode": "<string>",  
  "username": "<string>"  
}
```
**Purpose**: Join an existing game with a valid `gameCode`.  

---

### 4. Join Game Success
**Direction**: Server → Client  
```json
{  
  "type": "joinGameSuccess",  
  "usernames": [ "<string>", ... ]  
}
```
**Purpose**: Informs a client that joining was successful, listing all current players.

---

### 5. New User Joined
**Direction**: Server → Broadcast  
```json
{  
  "type": "newUserJoined",  
  "username": "<string>"  
}
```
**Purpose**: Notifies all players that a new user has joined the game.

---

### 6. Start Game
**Direction**: Client → Server  
```json
{  
  "type": "startGame",  
  "cardIds": [ [ <int>, <int>, ... ], ... ],  
  "cardDeckJson": "<string>"  
}
```
**Purpose**: Sent by the game creator to start the game. The message includes a list of card IDs per player and the card deck as JSON string.

---

### 7. Start Game Success
**Direction**: Server → Client (to all players)
```json
{  
  "type": "startGameSuccess",  
  "cardIds": [ <int>, <int>, ... ],  
  "cardDeckJson": "<string>"  
}
```
**Purpose**: Confirms the game has started, providing the players specific card ID list and the card deck to each player.

---

### 8. Send Card
**Direction**: Client → Server  
```json
{  
  "type": "sendCard",  
  "cardId": <int>,  
  "fromUsername": "<string>",  
  "toUsername": "<string>"  
}
```
**Purpose**: Sends or passes a card from one player to another.

---

### 9. Send Card Success
**Direction**: Server → Broadcast  
```json
{  
  "type": "sendCardSuccess",  
  "cardId": <int>,  
  "fromUsername": "<string>",  
  "toUsername": "<string>"  
}
```
**Purpose**: Notifies all players that a card was successfully sent.

---

### 10. Error
**Direction**: Server → Client  
```json
{  
  "type": "error",  
  "failureReason": "<string>"  
}
```
**Purpose**: Informs a client of an error (e.g., invalid request).


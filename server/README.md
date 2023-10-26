# TRUMP Cards - Server
This is the server for the *TRUMP Cards* game. The following describes the network protocol that defines how client and server communicate over a network. The exchanged data are UTF-8 encoded strings. A string encodes a sequence of data with `:` as an separator. 


## Create game
Client -> Server:
| Value 0 | Value 1 | Value 2
| ----- | ----- | ----- |
| CREATE_GAME | \<username> | \<carddeck id> |

Server -> Client:
| Value 0 | Value 1 |
| ----- | ----- |
| CREATE_GAME_SUCCESS | \<unique game code> |


## Join game
Client -> Server:
| Value 0 | Value 1 | Value 2 |
| ----- | ----- | ----- |
| JOIN_GAME | \<game code> | \<username> |

Server -> Client:
| Value 0 | Value 1 | Value 2 (optional) | Value 3 (optional) |
| ----- | ----- | ----- | ----- |
| JOIN_GAME_SUCCESS | \<username> | \<username> | \<username> |

Server -> Broadcast:
| Value 0 | Value 1 |
| ----- | ----- |
| NEW_USER_JOINED | \<username> |


## Start game
Client -> Server:
| Value 0 | Value 1 | Value 2 | Value 3 (optional) | Value 4 (optional) |
| ----- | ----- | ----- | ----- | ----- |
| START_GAME | \<list of card IDs> | \<list of card IDs> | \<list of card IDs> | \<list of card IDs> |

Server -> Client:
| Value 0 | Value 1 |
| ----- | ----- |
| START_GAME_SUCCESS | \<list of card IDs> |


## Send a card
Client -> Server:
| Value 0 | Value 1 | Value 2 |
| ----- | ----- | ----- |
| SEND_CARD | \<card ID> | \<from username> | \<to username> |

Server -> Broadcast:
| Value 0 | Value 1 | Value 2 |
| ----- | ----- | ----- |
| SEND_CARD_SUCCESS | \<card ID> | \<from username> | \<to username> |


## Error message
Server -> Client:
| Value 0 | Value 1 |
| ----- | ----- |
| ERROR  | \<failure reason> |
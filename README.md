<div align="center">
  <img src="./images/app-logo-rounded.png" alt="logo" width="150" height="auto" />
  <h1>Trump Cards</h1>
  <h4>
    <a href="https://play.google.com/store/apps/details?id=com.yedesign.card_game" target="_blank">Get it on Google Play</a> • 
    <a href="https://yanexr.github.io/trump-cards" target="_blank">Play on the Web</a>
  </h4>
</div>

**Trump Cards** is a a _super-trump_ or _trump-quartet_ card game like _Top Trumps_, where players compare numerical values of various attributes (e.g., speed, power) on their cards. Players take turns selecting a category and comparing the chosen attribute. The player with the highest value wins the round and collects the opponents' cards. The player who has all the cards at the end of the game wins.

## Screenshots
<div align="center">
  <img src="./images/screenshots.png" alt="screenshots" />
</div>

## Features

- 12 different card decks (3 on the client and 9 on the server)
- Each card shows a number of attributes, a picture and a more detailed description on the back
- 10 different card design themes to choose from
- Supports different measurement systems (metric, imperial, ...)
- Singleplayer with different difficulty levels
- Online and offline multiplayer
- Card and card deck editor for creating custom cards and card decks
- Supports 12 different languages

## Run the Code
The client is implemented in Dart/Flutter. The server (optional) is implemented in Python with WebSockets. Further details are available in the `README` files located in the [`client/`](client) and [`server/`](server) directories.


## Data
There are 12 card decks: Cars, Airplanes and Rockets are located in [`client/assets/carddecks/`](client/assets/carddecks), and Animals, Planetary Systems, Dinosaurs, Skyscrapers, Tanks, World Football Stars, World Tennis Stars, Extreme Sports and Mega Cities are located in [`server/data/`](server/data). A card deck is stored in a JSON file with the following structure:

```json
{
  "id": "number",
  "name": "string",
  "thumbnailPath": "string",
  "backgroundPath": "string",
  "characteristics": [
    {
      "measurementType": "string",  // e.g., "mass", "velocity"
      "isHigherBetter": "boolean",
      "label": "string"  // e.g., "Weight", "Speed"
    }
  ],
  "cards": [
    {
      "id": "number",
      "name": "string",
      "subtitle": "string",
      "imagePath": "string",
      "imageAttr": "string",
      "imageLic": "string",
      "values": ["number"]  // e.g., [1.23, 4.56]
    }
  ]
}
```

To add a new card deck, create a new JSON file in the appropriate directory and add the card deck to the list of card decks in [`client/assets/carddecks/localCardDecks.json`](client/assets/carddecks/localCardDecks.json) or [`server/data/serverCardDecks.json`](server/data/serverCardDecks.json). Alternatively, a card deck can be created in the app using the card deck editor GUI or by importing a JSON file. 

Image paths can be either URLs or local paths. Local images should be placed in [`client/assets/images/<YourCardDeckName>/`](client/assets/images) and the new directory should be added to the list of assets in [`client/pubspec.yaml`](client/pubspec.yaml).



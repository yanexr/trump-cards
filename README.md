<div align="center">
  <img src="./images/app-logo-rounded.png" alt="logo" width="150" height="auto" />
  <h1>TRUMP Cards</h1>
</div>

**TRUMP Cards** is a a *super-trump* or *trump-quartet* card game like *Top Trumps*, where players compare numerical values of various attributes (e.g., speed, power) on their cards. Players take turns selecting a category and comparing the chosen attribute. The player with the highest value wins the round and collects the opponents' cards. The player who has all the cards at the end of the game wins.

## Screenshots

## Features
- 3 different card decks (cars, airplanes and rockets)
- Each card shows 5 different attributes, a picture and a more detailed description on the back
- Supports different measurement systems (metric, imperial, ...)
- Singleplayer with different difficulty levels
- Online and offline multiplayer
- Card editor for creating custom cards
- Supports 11 different languages

## How to add or change card decks
New card decks can be added, or existing ones can be changed by editing the `client/lib/data` directory.

1. To create a new card deck, first create a list of cards of type `List<GameCard>` with a length of at least 30.

2. Then create and add your card deck to the list of card decks in `cardDecks.dart`.

3. Finally, create a new directory (same name as your card deck) in the `client/assets/images/<YourCardDeckName>` directory and add the images of the cards and a background image `background.jpg` to it. Add your new directory to the list of assets in the `client/pubspec.yaml` file.


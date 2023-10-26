# TRUMP Cards - Client

This is the client for the *TRUMP Cards* game.

## Run the code
To build and run the client, first make sure that you have [Flutter](https://docs.flutter.dev/) installed and set up. Then, clone the repository and run the following commands in the client directory of the project:

    ```
    flutter pub get
    flutter run
    ```

## How to add or change card decks
New card decks can be added, or existing ones can be changed by editing the `client/lib/data` directory.

1. To create a new card deck, first create a list of cards of type `List<GameCard>` with a length of at least 30.

2. Then create and add your card deck to the list of card decks in `cardDecks.dart`.

3. Finally, create a new directory (same name as your card deck) in the `client/assets/images/<YourCardDeckName>` directory and add the images of the cards and a background image `background.jpg` to it. Add your new directory to the list of assets in the `client/pubspec.yaml` file.
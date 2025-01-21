import 'dart:convert';
import 'dart:math';
import 'dart:io' show File;

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trump_cards/app.dart';
import 'package:trump_cards/editor/cardDeckEditor.dart';
import 'package:trump_cards/editor/deleteDialog.dart';
import 'package:trump_cards/gameCard/cards.dart';
import 'package:path/path.dart' as p;

Future<void> saveFileWithPicker({
  required String baseName,
  required Uint8List bytes,
  required String extension,
  required String mimeType,
}) async {
  // use file_saver package for web
  if (kIsWeb) {
    await FileSaver.instance.saveFile(
      name: baseName,
      bytes: bytes,
      ext: extension,
      mimeType: extension == 'json' ? MimeType.json : MimeType.csv,
    );
    return;
  }

  // use file_picker package for other platforms
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if (selectedDirectory == null) {
    throw Exception('User canceled directory selection');
  }

  // Compose the final file path
  final fileName = '$baseName.$extension';
  final filePath = p.join(selectedDirectory, fileName);

  // Write the file
  final file = File(filePath);
  await file.writeAsBytes(bytes);
}

class Carddecklibrary extends StatefulWidget {
  const Carddecklibrary({super.key});

  static const routeName = '/card-deck-library';

  @override
  _CarddecklibraryState createState() => _CarddecklibraryState();
}

class _CarddecklibraryState extends State<Carddecklibrary> {
  List<GameCardDeckEntry> _localDecks = [];
  List<GameCardDeckEntry> _userCreatedDecks = [];
  List<GameCardDeckEntry> _remoteDecks = [];
  bool _isLocalLoading = true;
  bool _isUserCreatedLoading = true;
  bool _isRemoteLoading = false;
  bool _remoteError = false;

  MenuController? _menuController;

  @override
  void initState() {
    super.initState();
    _loadLocalDecks();
  }

  Future<void> _loadLocalDecks() async {
    try {
      final localDecks = await parseGameCardDeckEntries(
          'assets/carddecks/localCardDecks.json');
      if (mounted) {
        setState(() {
          _localDecks = localDecks;
          _isLocalLoading = false;
        });
        _loadUserCreatedDecks();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLocalLoading = false;
        });
      }
    }
  }

  Future<void> _loadUserCreatedDecks() async {
    try {
      final usercreatedDecks = await parseUserCreatedGameCardDeckEntries();
      if (mounted) {
        setState(() {
          _userCreatedDecks = usercreatedDecks;
          _isUserCreatedLoading = false;
        });
        _loadRemoteDecks();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isUserCreatedLoading = false;
        });
      }
    }
  }

  Future<void> _loadRemoteDecks() async {
    setState(() {
      _isRemoteLoading = true;
      _remoteError = false;
    });
    try {
      final remoteDecks = await parseGameCardDeckEntries(
          'https://raw.githubusercontent.com/yanexr/trump-cards/refs/heads/main/server/data/serverCardDecks.json');
      if (mounted) {
        setState(() {
          _remoteDecks = remoteDecks;
          _isRemoteLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isRemoteLoading = false;
          _remoteError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If still loading local decks:
    if (_isLocalLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(tr('Card Deck Library')),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Local decks finished loading
    if (_localDecks.isEmpty) {
      // No local decks found
      return Scaffold(
        appBar: AppBar(
          title: Text(tr('Card Deck Library')),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Text(tr('No decks found')),
        ),
      );
    }

    // Combine local and remote decks
    final allDecks = [..._localDecks, ..._userCreatedDecks, ..._remoteDecks];

    final ButtonStyle menuItemStyle = ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(150, 50)),
      padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0)),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Card Deck Library')),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.fromLTRB(0, 0, 40, 10),
          child: PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Theme.of(context).colorScheme.primary,
            position: PopupMenuPosition.over,
            offset: const Offset(0, -50),
            itemBuilder: (context) => [
              // Create New Card Deck
              PopupMenuItem(
                child: Row(
                  children: [
                    const Icon(Icons.edit, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(tr('Create New'),
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, '/card-deck-editor'),
              ),
              // Import Card Deck from JSON file
              PopupMenuItem(
                child: Row(
                  children: [
                    const Icon(Icons.upload_file, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('${tr('Import')} (JSON)',
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () async {
                  try {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['json'],
                      withData: true,
                    );
                    if (result != null && result.files.isNotEmpty) {
                      Uint8List? fileBytes = result.files.first.bytes;
                      String fileContent = utf8.decode(fileBytes!);
                      GameCardDeck newDeck =
                          GameCardDeck.fromJson(jsonDecode(fileContent));

                      // Save the imported deck to shared preferences
                      int newId = Random().nextInt(900000000) + 100000000;
                      newDeck.id = newId;
                      newDeck.isUserCreated = true;
                      saveGameCardDeck("gameCardDeck$newId", newDeck);

                      if (!mounted) return;
                      Navigator.of(context).pop(newDeck);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                              '✔ Successfully imported deck: ${tr(newDeck.name)}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('✗ No file selected.',
                                style: TextStyle(color: Colors.white))),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('✗ Failed to import deck: $e',
                              style: const TextStyle(color: Colors.white))),
                    );
                  }
                },
              ),
            ],
            child: Semantics(
              button: true,
              label: 'Add new card deck',
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: null, // PopupMenuButton handles the press
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 100),
            child: Column(
              children: [
                ...allDecks.map((deck) {
                  final isNetworkImage = deck.thumbnailPath.startsWith('http');
                  Widget thumbnail;
                  if (isNetworkImage) {
                    thumbnail = Image.network(
                      deck.thumbnailPath,
                      fit: BoxFit.cover,
                      height: 128,
                      width: 128,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.cover,
                          height: 128,
                          width: 128,
                        );
                      },
                    );
                  } else {
                    thumbnail = Image.asset(
                      "assets/images/${deck.thumbnailPath}",
                      fit: BoxFit.cover,
                      height: 128,
                      width: 128,
                    );
                  }

                  return Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            GameCardDeck selectedCardDeck =
                                await loadGameCardDeck(deck.path,
                                    fromShPref: deck.id != 0);
                            if (deck.id != 0) {
                              selectedCardDeck.isUserCreated = true;
                            } else {
                              selectedCardDeck.addUserCreatedCards();
                            }
                            if (!mounted) return;
                            Navigator.of(context).pop(selectedCardDeck);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Material(
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                    width: 128,
                                    height: 128,
                                    child: thumbnail,
                                    ),
                                  ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              tr(deck.name),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          if (deck.id == 0 &&
                                              ['Cars', 'Airplanes', 'Rockets']
                                                  .contains(deck.name))
                                            const Icon(Icons.verified,
                                                color: Colors.blue, size: 16),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(
                                              Icons.style,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            deck.numberOfCards,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Menu button
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: MenuAnchor(
                          menuChildren: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (deck.id != 0) ...[
                                    // Edit
                                    MenuItemButton(
                                      style: menuItemStyle,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CardDeckEditor(
                                                    shPrefKey: deck.path),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.edit),
                                          const SizedBox(width: 8),
                                          Text(tr('Edit')),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Delete
                                    MenuItemButton(
                                      style: menuItemStyle,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return DeleteDialog(
                                              deleteFunction: () async {
                                                if (App.selectedCardDeck!.id ==
                                                    deck.id) {
                                                  GameCardDeck
                                                      selectedCardDeck =
                                                      await loadGameCardDeck(
                                                          'assets/carddecks/cars.json');
                                                  selectedCardDeck
                                                      .addUserCreatedCards();
                                                  if (!mounted) return;
                                                  Navigator.of(context)
                                                      .pop(selectedCardDeck);
                                                } else {
                                                  setState(() {
                                                    _userCreatedDecks
                                                        .remove(deck);
                                                  });
                                                }
                                                SharedPreferences.getInstance()
                                                    .then((prefs) {
                                                  prefs.remove(deck.path);
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      '✔ ${tr('Card Deck deleted successfully')}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              name: tr(deck.name),
                                              title: tr('Delete Card Deck'),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.delete),
                                          const SizedBox(width: 8),
                                          Text(tr('Delete')),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                  // Export as JSON
                                  MenuItemButton(
                                    style: menuItemStyle,
                                    onPressed: () async {
                                      try {
                                        // 1) Load deck & add user-created cards
                                        GameCardDeck deckExport =
                                            await loadGameCardDeck(
                                          deck.path,
                                          fromShPref: deck.id != 0,
                                        );
                                        await deckExport.addUserCreatedCards();

                                        // 2) Convert to JSON => bytes
                                        final Map<String, dynamic> data =
                                            deckExport.toJson();
                                        final String jsonString =
                                            jsonEncode(data);
                                        final Uint8List bytes =
                                            Uint8List.fromList(
                                                utf8.encode(jsonString));

                                        // 3) Build file name & save
                                        final String baseName =
                                            '${deck.name} - Card Deck';

                                        await saveFileWithPicker(
                                          baseName: baseName,
                                          bytes: bytes,
                                          extension: 'json',
                                          mimeType: 'application/json',
                                        );

                                        // 4) Show success
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              '✔ Exported successfully as $baseName.json',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              '✗ Failed to export the deck: $e',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.download),
                                        SizedBox(width: 8),
                                        Text('JSON'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Export as CSV
                                  MenuItemButton(
                                    style: menuItemStyle,
                                    onPressed: () async {
                                      try {
                                        // 1) Load deck & add custom cards
                                        GameCardDeck deckExport =
                                            await loadGameCardDeck(
                                          deck.path,
                                          fromShPref: deck.id != 0,
                                        );
                                        await deckExport.addUserCreatedCards();

                                        // 2) Convert to CSV => bytes
                                        final String csvString =
                                            deckExport.toCSV();
                                        final Uint8List bytes =
                                            Uint8List.fromList(
                                                utf8.encode(csvString));

                                        // 3) Build file name & save
                                        final String baseName =
                                            '${deck.name} - Card Deck';

                                        await saveFileWithPicker(
                                          baseName: baseName,
                                          bytes: bytes,
                                          extension: 'csv',
                                          mimeType: 'text/csv',
                                        );

                                        // 4) Show success
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              '✔ Exported successfully as $baseName.csv',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              '✗ Failed to export the deck: $e',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.download),
                                        SizedBox(width: 8),
                                        Text('CSV'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          builder: (BuildContext context,
                              MenuController controller, _) {
                            _menuController ??= controller;
                            return Semantics(
                              button: true,
                              label: 'More options',
                              child: IconButton(
                                tooltip: 'More options',
                                icon: const Icon(Icons.more_vert),
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 20),
                if (_isRemoteLoading)
                  const Center(child: CircularProgressIndicator()),
                if (_remoteError)
                  Text(
                    tr('Unable to load remote decks'),
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

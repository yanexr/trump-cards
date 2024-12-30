import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trump_cards/app.dart';
import 'package:trump_cards/settings/settingsController.dart';
import '../gameCard/cards.dart';
import '../gameCard/gameCardBack.dart';
import 'gameCardFront.dart';

class GameCardWidget extends StatefulWidget {
  final GameCard gameCard;
  final bool isSelectable;
  final int selectedCharacteristic;
  final Color selectionColor;
  final Function(int) onClick;
  final bool elevation;
  final GameCardDeck? deck;

  const GameCardWidget(
      {super.key,
      required this.gameCard,
      this.isSelectable = false,
      this.selectedCharacteristic = -1,
      this.selectionColor = Colors.blue,
      this.onClick = _doNothing,
      this.elevation = true,
      this.deck});

  static void _doNothing(int s) {}

  @override
  _GameCardWidgetState createState() => _GameCardWidgetState();
}

class _GameCardWidgetState extends State<GameCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  void flipCard() {
    if (!_animationController.isAnimating) {
      if (_animationController.value < .5) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
            child: AnimatedBuilder(
      animation: _animationController,
      builder: ((context, child) {
        return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // add a small perspective effect
              ..rotateY(3.14159 * _animation.value), // rotate around the Y-axis
            alignment: Alignment.center,
            child: _animationController.value < .5
                ? GameCardFront(
                    gameCard: widget.gameCard,
                    flipCard: flipCard,
                    isSelectable: widget.isSelectable,
                    selectedCharacteristic: widget.selectedCharacteristic,
                    selectionColor: widget.selectionColor,
                    onClick: widget.onClick,
                    elevation: widget.elevation,
                    deck: widget.deck ?? App.selectedCardDeck,
                  )
                : Transform.flip(
                    flipX: true,
                    child: GameCardBack(
                        gameCard: widget.gameCard,
                        flipCard: flipCard,
                        elevation: widget.elevation,
                        languageCode: context.locale.languageCode)));
      }),
    )));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class GameCardStyle {
  final String name;

  // front
  TextStyle? title;
  TextStyle? text;
  String? frontLabelFontFamily;
  final Color? frontLabelColor;
  String? frontValueFontFamily;
  final Color? frontValueColor;
  // shape
  final double? borderRadius;
  final bool isSlanted;
  // shadow
  final bool hasShadow;
  // border container
  final Gradient? borderContainerGradient;
  final DecorationImage? borderContainerImage;
  // inner container
  final Gradient? innerContainerGradient;
  final DecorationImage? innerContainerImage;
  // attribute container
  final Gradient? attributeContainerGradient;
  final DecorationImage? attributeContainerImage;

  static final String? _meddon = GoogleFonts.meddon().fontFamily;
  static final String? _homemadeApple = GoogleFonts.homemadeApple().fontFamily;
  static final String? _robotoMono = GoogleFonts.robotoMono().fontFamily;
  static final String? _bangers = GoogleFonts.bangers().fontFamily;
  static final String? _rubikDirt = GoogleFonts.rubikDirt().fontFamily;
  static final String? _audiowide = GoogleFonts.audiowide().fontFamily;

  GameCardStyle(
      {this.name = 'Default',

      // front
      this.title = const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, fontFamily: null),
      this.text = const TextStyle(fontSize: 14, fontFamily: null),
      this.frontLabelFontFamily,
      this.frontLabelColor,
      this.frontValueFontFamily,
      this.frontValueColor,
      // shape
      this.borderRadius,
      this.isSlanted = false,
      // shadow
      this.hasShadow = true,
      // border container
      this.borderContainerGradient,
      this.borderContainerImage,
      // inner container
      this.innerContainerGradient,
      this.innerContainerImage,
      // attribute container
      this.attributeContainerGradient,
      this.attributeContainerImage});

////////////////////////////////////////

  static final GameCardStyle _royalElegance = GameCardStyle(
    name: 'Royal Elegance',
    title: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: const Color.fromARGB(255, 185, 139, 0),
      fontFamily: _meddon,
    ),
    text: TextStyle(
      fontSize: 14,
      color: const Color.fromARGB(255, 185, 139, 0),
      fontFamily: _meddon,
    ),
    frontLabelFontFamily: _meddon,
    frontLabelColor: const Color.fromARGB(255, 185, 139, 0),
    frontValueFontFamily: _meddon,
    frontValueColor: const Color.fromARGB(255, 185, 139, 0),
    borderRadius: null,
    isSlanted: false,
    hasShadow: true,
    borderContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(255, 165, 124, 0),
        Color.fromARGB(255, 165, 124, 0),
      ],
    ),
    borderContainerImage: null,
    innerContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(255, 0, 35, 105),
        Color.fromARGB(255, 0, 35, 105),
      ],
    ),
    innerContainerImage: null,
    attributeContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(255, 0, 27, 80),
        Color.fromARGB(255, 0, 27, 80),
      ],
    ),
    attributeContainerImage: null,
  );

  ////////////////////////////////////////

  static final GameCardStyle _Handwritten = GameCardStyle(
    name: 'Handwritten',
    title: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: const Color.fromARGB(255, 0, 35, 135),
      fontFamily: _homemadeApple,
    ),
    text: TextStyle(
      fontSize: 14,
      color: const Color.fromARGB(255, 0, 35, 135),
      fontFamily: _homemadeApple,
    ),
    frontLabelFontFamily: _homemadeApple,
    frontLabelColor: const Color.fromARGB(255, 0, 35, 135),
    frontValueFontFamily: _homemadeApple,
    frontValueColor: const Color.fromARGB(255, 0, 35, 135),
    borderRadius: 0,
    isSlanted: false,
    hasShadow: false,
    borderContainerGradient: null,
    borderContainerImage: const DecorationImage(
      image: AssetImage('assets/images/paper.png'),
      fit: BoxFit.contain,
    ),
    innerContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(0, 0, 0, 0),
        Color.fromARGB(0, 0, 0, 0),
      ],
    ),
    innerContainerImage: null,
    attributeContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(0, 0, 0, 0),
        Color.fromARGB(0, 0, 0, 0),
      ],
    ),
    attributeContainerImage: null,
  );

  ////////////////////////////////////////

  static final GameCardStyle _terminal = GameCardStyle(
    name: 'Terminal',
    title: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: const Color.fromARGB(255, 0, 255, 0),
      fontFamily: _robotoMono,
    ),
    text: TextStyle(
      fontSize: 14,
      color: const Color.fromARGB(255, 0, 156, 0),
      fontFamily: _robotoMono,
    ),
    frontLabelFontFamily: _robotoMono,
    frontLabelColor: const Color.fromARGB(255, 0, 255, 0),
    frontValueFontFamily: _robotoMono,
    frontValueColor: const Color.fromARGB(255, 0, 255, 0),
    borderRadius: 5,
    isSlanted: false,
    hasShadow: true,
    borderContainerGradient: const LinearGradient(
      colors: [
        Colors.black,
        Colors.black,
      ],
    ),
    borderContainerImage: null,
    innerContainerGradient: const LinearGradient(
      colors: [
        Colors.black,
        Colors.black,
      ],
    ),
    innerContainerImage: null,
    attributeContainerGradient: const LinearGradient(
      colors: [
        Colors.black,
        Colors.black,
      ],
    ),
    attributeContainerImage: null,
  );

////////////////////////////////////////

  static final GameCardStyle _cosmicGlow = GameCardStyle(
    name: 'Cosmic Glow',
    title: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.yellow,
      fontFamily: _audiowide,
    ),
    text: TextStyle(
      fontSize: 14,
      color: Colors.yellow,
      fontFamily: _audiowide,
    ),
    frontLabelFontFamily: _audiowide,
    frontLabelColor: Colors.yellow,
    frontValueFontFamily: _audiowide,
    frontValueColor: Colors.yellow,
    borderRadius: null,
    isSlanted: false,
    hasShadow: true,
    borderContainerGradient: null,
    borderContainerImage: const DecorationImage(
      image: AssetImage('assets/images/galaxy.jpg'),
      fit: BoxFit.cover,
    ),
    innerContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(80, 0, 120, 167),
        Color.fromARGB(80, 0, 120, 167),
      ],
    ),
    innerContainerImage: null,
    attributeContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(128, 167, 0, 125),
        Color.fromARGB(128, 167, 0, 125),
      ],
    ),
    attributeContainerImage: null,
  );

  ////////////////////////////////////////

  static final GameCardStyle _minimalEssence = GameCardStyle(
    name: 'Minimal Essence',
    title: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black,
      fontFamily: _robotoMono,
    ),
    text: TextStyle(
      fontSize: 14,
      color: const Color.fromARGB(255, 32, 32, 32),
      fontFamily: _robotoMono,
    ),
    frontLabelFontFamily: _robotoMono,
    frontLabelColor: Colors.black,
    frontValueFontFamily: _robotoMono,
    frontValueColor: Colors.black,
    borderRadius: 0,
    isSlanted: false,
    hasShadow: true,
    borderContainerGradient: const LinearGradient(
      colors: [
        Colors.white,
        Colors.white,
      ],
    ),
    borderContainerImage: null,
    innerContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(255, 233, 233, 233),
        Color.fromARGB(255, 233, 233, 233),
      ],
    ),
    innerContainerImage: null,
    attributeContainerGradient: const LinearGradient(
      colors: [
        Colors.white,
        Colors.white,
      ],
    ),
    attributeContainerImage: null,
  );

  ////////////////////////////////////////

  static final GameCardStyle _caution = GameCardStyle(
    name: 'Caution!',
    title: TextStyle(
      fontSize: 20,
      color: const Color.fromARGB(255, 255, 255, 0),
      fontFamily: _rubikDirt,
    ),
    text: TextStyle(
      fontSize: 13,
      color: const Color.fromARGB(255, 216, 216, 0),
      fontFamily: _rubikDirt,
    ),
    frontLabelFontFamily: _rubikDirt,
    frontLabelColor: Colors.black,
    frontValueFontFamily: _rubikDirt,
    frontValueColor: Colors.black,
    borderRadius: null,
    isSlanted: false,
    hasShadow: true,
    borderContainerGradient: null,
    borderContainerImage: const DecorationImage(
      image: AssetImage('assets/images/black-yellow.png'),
      fit: BoxFit.cover,
    ),
    innerContainerGradient: const LinearGradient(
      colors: [
        Colors.black,
        Colors.black,
      ],
    ),
    innerContainerImage: null,
    attributeContainerGradient: const LinearGradient(
      colors: [
        Color.fromARGB(255, 255, 255, 0),
        Color.fromARGB(255, 255, 255, 0),
      ],
    ),
    attributeContainerImage: null,
  );

  ////////////////////////////////////////

  static final GameCardStyle _colorfulGradient = GameCardStyle(
      name: 'Colorful Gradient',
      title: TextStyle(
        fontSize: 22,
        color: const Color.fromARGB(255, 163, 88, 170),
        fontFamily: _bangers,
      ),
      text: TextStyle(
        fontSize: 15,
        color: const Color.fromARGB(255, 117, 63, 122),
        fontFamily: _bangers,
      ),
      frontLabelFontFamily: _bangers,
      frontLabelColor: const Color.fromARGB(255, 163, 88, 170),
      frontValueFontFamily: _bangers,
      frontValueColor: const Color.fromARGB(255, 163, 88, 170),
      borderRadius: 40,
      isSlanted: false,
      hasShadow: false,
      borderContainerGradient: null,
      borderContainerImage: const DecorationImage(
        image: AssetImage('assets/images/colored.jpg'),
        fit: BoxFit.cover,
      ),
      innerContainerGradient: const LinearGradient(
        colors: [
          Color.fromARGB(60, 255, 255, 255),
          Color.fromARGB(60, 255, 255, 255),
        ],
      ),
      innerContainerImage: null,
      attributeContainerGradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(101, 255, 255, 255),
          Color.fromARGB(101, 255, 255, 255),
        ],
      ),
      attributeContainerImage: null);

  ////////////////////////////////////////

  static final GameCardStyle _neonLights = GameCardStyle(
      name: 'Neon Lights',
      title: TextStyle(
        fontSize: 22,
        color: const Color.fromARGB(255, 254, 255, 56),
        fontFamily: _bangers,
      ),
      text: TextStyle(
        fontSize: 15,
        color: const Color.fromARGB(255, 39, 2, 69),
        fontFamily: _bangers,
      ),
      frontLabelFontFamily: _bangers,
      frontLabelColor: const Color.fromARGB(255, 254, 255, 56),
      frontValueFontFamily: _bangers,
      frontValueColor: const Color.fromARGB(255, 254, 255, 56),
      borderRadius: 0,
      isSlanted: true,
      hasShadow: true,
      borderContainerGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 39, 2, 69),
          Color.fromARGB(255, 135, 26, 133),
        ],
      ),
      borderContainerImage: null,
      innerContainerGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 254, 24, 211),
          Color.fromARGB(255, 255, 41, 65),
        ],
      ),
      innerContainerImage: null,
      attributeContainerGradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(255, 39, 2, 69),
          Color.fromARGB(255, 135, 26, 133),
        ],
      ),
      attributeContainerImage: null);

////////////////////////////////////////

  static final GameCardStyle _oceanGradient = GameCardStyle(
      name: 'Ocean Gradient',
      title: TextStyle(
        fontSize: 22,
        color: const Color.fromARGB(255, 34, 44, 48),
        fontFamily: _bangers,
      ),
      text: TextStyle(
        fontSize: 15,
        color: const Color.fromARGB(255, 60, 78, 85),
        fontFamily: _bangers,
      ),
      frontLabelFontFamily: _bangers,
      frontLabelColor: Colors.white,
      frontValueFontFamily: _bangers,
      frontValueColor: Colors.white,
      borderRadius: null,
      isSlanted: false,
      hasShadow: true,
      borderContainerGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2196F3),
          Color(0xFF4CAF50),
        ],
      ),
      borderContainerImage: null,
      innerContainerGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(60, 255, 255, 255),
          Color.fromARGB(60, 255, 255, 255),
        ],
      ),
      innerContainerImage: null,
      attributeContainerGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(108, 33, 149, 243),
          Color.fromARGB(108, 33, 149, 243),
        ],
      ),
      attributeContainerImage: null);

  static final GameCardStyle _defaultStyle = GameCardStyle();

  static final List<GameCardStyle> styles = [
    _defaultStyle,
    _caution,
    _colorfulGradient,
    _cosmicGlow,
    _Handwritten,
    _minimalEssence,
    _neonLights,
    _oceanGradient,
    _royalElegance,
    _terminal
  ];

  static GameCardStyle get style {
    return styles[SettingsController.instance.cardDesign];
  }
}

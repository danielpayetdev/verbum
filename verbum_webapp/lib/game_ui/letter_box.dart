import 'package:flutter/material.dart';

class RedLetter extends LetterBox {
  const RedLetter({Key? key, required letter}) : super(key: key, color: Colors.red, letter: letter);
}

class YollowLetter extends LetterBox {
  const YollowLetter({Key? key, required letter}) : super(key: key, color: Colors.yellow, letter: letter);
}

class BlueLetter extends LetterBox {
  const BlueLetter({Key? key, required letter}) : super(key: key, color: Colors.blue, letter: letter);
}

abstract class LetterBox extends StatelessWidget {
  final String letter;
  final Color color;
  const LetterBox({Key? key, required this.color, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: color,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            letter,
            textScaleFactor: 1.0,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

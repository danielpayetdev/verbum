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
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: const Border(
          top: BorderSide(width: 1.0, color: Colors.white),
          left: BorderSide(width: 1.0, color: Colors.white),
          bottom: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.white),
        ),
      ),
      child: Center(
        child: Text(
          letter,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

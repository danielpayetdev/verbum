import 'package:flutter/material.dart';
import 'package:verbum_webapp/game/game.provider.dart';
import 'package:verbum_webapp/game_ui/letter_box.dart';

class Grille extends StatelessWidget {
  final GameGrid wordGrid;
  const Grille({Key? key, required this.wordGrid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white, width: 1.0),
      children: wordGrid.map((row) {
        return TableRow(
          children: row.map((cell) {
            return _getBox(cell);
          }).toList(),
        );
      }).toList(),
    );
  }

  LetterBox _getBox(Letter letter) {
    switch (letter.state) {
      case Status.first:
        return RedLetter(letter: letter.letter!);
      case Status.typed:
        return BlueLetter(letter: letter.letter!);
      case Status.tofound:
        return const BlueLetter(letter: ".");
      case Status.notInWord:
        return BlueLetter(letter: letter.letter!);
      case Status.found:
        return RedLetter(letter: letter.letter!);
      case Status.almostFound:
        return YollowLetter(letter: letter.letter!);
      default:
        return const BlueLetter(letter: "");
    }
  }
}

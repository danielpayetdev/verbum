import 'package:flutter/material.dart';
import 'package:verbum_webapp/game/game_state.dart';
import 'package:verbum_webapp/game/letter.dart';
import 'package:verbum_webapp/game/letter_status.dart';
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
      case LetterStatus.first:
        return RedLetter(letter: letter.letter!);
      case LetterStatus.typed:
        return BlueLetter(letter: letter.letter!);
      case LetterStatus.tofound:
        return const BlueLetter(letter: ".");
      case LetterStatus.notInWord:
        return BlueLetter(letter: letter.letter!);
      case LetterStatus.found:
        return RedLetter(letter: letter.letter!);
      case LetterStatus.almostFound:
        return YollowLetter(letter: letter.letter!);
      default:
        return const BlueLetter(letter: "");
    }
  }
}

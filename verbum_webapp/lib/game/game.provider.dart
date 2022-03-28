import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

typedef GameGrid = List<List<Letter>>;

class GameStats {
  final String word;
  final int nombreDeMot;
  final GameGrid wordGrid;

  GameStats(this.word, this.nombreDeMot, this.wordGrid);
}

const int numberOfRows = 6;

class GameProvider extends ChangeNotifier {
  String word = "";
  GameGrid wordGrid = [];
  int currentLetter = 1;
  int currentRow = 0;
  List<int> letterFinds = [];
  List<int> letterAlmostFinds = [];
  List<String> notInWord = [];
  bool isOver = false;
  bool isWon = false;

  Future start() async {
    word = await _getWord();
    wordGrid = initWordGrid();
    currentLetter = 1;
    currentRow = 0;
    letterFinds = [];
    letterAlmostFinds = [];
    notInWord = [];
    isOver = false;
    isWon = false;
  }

  GameGrid initWordGrid() {
    return List.generate(
      numberOfRows,
      (index) => List.generate(
        word.length,
        (index2) {
          if (index == 0) {
            if (index2 == 0) {
              return Letter(letter: word.characters.first, state: Status.first);
            } else {
              return Letter(state: Status.tofound);
            }
          } else {
            return Letter(state: Status.clear);
          }
        },
      ),
    );
  }

  Future<String> _getWord() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getWord');
    final results = await callable();
    return results.data;
  }

  void typeLetter(String letter) {
    if (currentLetter < word.length) {
      var letterBox = wordGrid[currentRow][currentLetter];
      letterBox.letter = letter;
      letterBox.state = Status.typed;
      currentLetter++;
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (currentLetter > 1) {
      var letterBox = wordGrid[currentRow][currentLetter - 1];
      letterBox.letter = "";
      letterBox.state = Status.tofound;
      currentLetter--;
      notifyListeners();
    }
  }

  void submit() {
    if (currentLetter == word.length) {
      var row = wordGrid[currentRow];
      Map<String, int> letterFinds = {};
      for (var i = 0; i < row.length; i++) {
        if (row[i].letter == word[i]) {
          row[i].state = Status.found;
          letterFinds.update(row[i].letter!, (value) => value + 1, ifAbsent: () => 1);
          for (var element in wordGrid[currentRow]) {
            if(element.letter == row[i].letter && element.state == Status.almostFound) {
              element.state = Status.notInWord;
              break;
            }
          }
        } else if (_isAlmostFound(row[i], letterFinds)) {
          row[i].state = Status.almostFound;
          letterFinds.update(row[i].letter!, (value) => value + 1, ifAbsent: () => 1);
        } else {
          row[i].state = Status.notInWord;
        }
      }
      if (row.map((r) => r.letter).join() == word) {
        isWon = true;
        isOver = true;
      } else if (currentRow == wordGrid.length - 1) {
        isOver = true;
      } else {
        currentRow++;
        for (var element in wordGrid[currentRow]) {
          element.state = Status.tofound;
        }
        var firstLetter = wordGrid[currentRow][0];
        firstLetter.letter = word.characters.first;
        firstLetter.state = Status.first;
        currentLetter = 1;
      }
      notifyListeners();
    }
  }

  bool _isAlmostFound(Letter letter, Map<String, int> letterFinds) {
    var numberSeeing = letterFinds[letter.letter!] ?? 0;
    var numberInWord = word.characters.where((char) => char == letter.letter!).length;
    return word.contains(letter.letter!) && numberSeeing < numberInWord;
  }

  GameStats getStatistique() {
    return GameStats(word, currentRow + 1, wordGrid);
  }
}

enum Status { first, typed, notInWord, almostFound, found, tofound, clear }

class Letter {
  String? letter;
  Status state;
  Letter({Key? key, this.letter, required this.state});
}

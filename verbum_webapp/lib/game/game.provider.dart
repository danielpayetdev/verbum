import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verbum_webapp/game/game_state.dart';
import 'package:verbum_webapp/game/letter.dart';
import 'package:verbum_webapp/game/letter_status.dart';

const int numberOfRows = 6;

class GameProvider extends ChangeNotifier {
  GameState? game;
  var error$ = StreamController<String>.broadcast();

  Future start() async {
    var datas = await Future.wait([SharedPreferences.getInstance(), _getWord(), _getAcceptableWords()]);
    final prefs = datas[0] as SharedPreferences;
    final wordFromBdd = datas[1] as String;
    var gameFromPrefs = prefs.getString("game");
    if (gameFromPrefs != null) {
      try {
        GameState _game;
        dynamic json = jsonDecode(gameFromPrefs);
        _game = GameState.fromJson(json);
        if (_game.word == wordFromBdd) {
          game = _game;
          game!.acceptableWords = await _getAcceptableWords();
          notifyListeners();
          return;
        } else {
          await prefs.remove("game");
        }
      } on Exception catch (_) {
        await prefs.remove("game");
      }
    }
    game = GameState(word: datas[1] as String, acceptableWords: datas[2] as List<String>);
  }

  Future<String> _getWord() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('words');
    final docLast = await collection.orderBy("day").limitToLast(1).get();
    return docLast.docs.map((d) => d.get("word")).first;
  }

  Future<List<String>> _getAcceptableWords() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getAcceptableWords');
    final results = await callable.call<List<Object?>>();
    return results.data.map((d) => d.toString()).toList();
  }

  void typeLetter(String letter) {
    if (game!.currentLetter < game!.word.length) {
      var letterBox = game!.wordGrid[game!.currentRow][game!.currentLetter];
      letterBox.letter = letter;
      letterBox.state = LetterStatus.typed;
      game!.currentLetter++;
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (game!.currentLetter > 1) {
      var letterBox = game!.wordGrid[game!.currentRow][game!.currentLetter - 1];
      letterBox.letter = "";
      letterBox.state = LetterStatus.tofound;
      game!.currentLetter--;
      notifyListeners();
    }
  }

  void submit() {
    if (game!.currentLetter == game!.word.length) {
      var row = game!.wordGrid[game!.currentRow];
      if (!_isWordValid(row.map((l) => l.letter).join())) {
        showError("Ce mot n'existe pas ! 🤓 Essayez un autre mot.");
        for (var i = 1; i < game!.wordGrid[game!.currentRow].length; i++) {
          game!.wordGrid[game!.currentRow][i].state = LetterStatus.tofound;
          game!.wordGrid[game!.currentRow][i].letter = null;
          notifyListeners();
        }
        game!.currentLetter = 1;
      } else {
        Map<String, int> letterFinds = {};
        for (var i = 0; i < row.length; i++) {
          if (row[i].letter == game!.word[i]) {
            row[i].state = LetterStatus.found;
            letterFinds.update(row[i].letter!, (value) => value + 1, ifAbsent: () => 1);
            for (var element in game!.wordGrid[game!.currentRow]) {
              if (element.letter == row[i].letter && element.state == LetterStatus.almostFound) {
                element.state = LetterStatus.notInWord;
                break;
              }
            }
          } else if (_isAlmostFound(row[i], letterFinds)) {
            row[i].state = LetterStatus.almostFound;
            letterFinds.update(row[i].letter!, (value) => value + 1, ifAbsent: () => 1);
          } else {
            row[i].state = LetterStatus.notInWord;
          }
        }
        if (row.map((r) => r.letter).join() == game!.word) {
          game!.isWon = true;
          game!.isOver = true;
        } else if (game!.currentRow == game!.wordGrid.length - 1) {
          game!.isOver = true;
        } else {
          game!.currentRow++;
          for (var element in game!.wordGrid[game!.currentRow]) {
            element.state = LetterStatus.tofound;
          }
          var firstLetter = game!.wordGrid[game!.currentRow][0];
          firstLetter.letter = game!.word.characters.first;
          firstLetter.state = LetterStatus.first;
          game!.currentLetter = 1;
        }
        notifyListeners();
      }
    }
  }

  bool _isWordValid(wordTyped) {
    return game!.acceptableWords.contains(wordTyped);
  }

  @override
  void notifyListeners() async {
    if (game != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("game", jsonEncode(game!.toJson()));
    }
    super.notifyListeners();
  }

  bool _isAlmostFound(Letter letter, Map<String, int> letterFinds) {
    var numberSeeing = letterFinds[letter.letter!] ?? 0;
    var numberInWord = game!.word.characters.where((char) => char == letter.letter!).length;
    return game!.word.contains(letter.letter!) && numberSeeing < numberInWord;
  }

  GameState getState() {
    return game!;
  }

  void showError(String error) {
    error$.add(error);
  }

  Stream<String> get errorStream => error$.stream;
}

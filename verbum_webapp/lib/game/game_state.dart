import 'package:flutter/widgets.dart';
import 'package:verbum_webapp/game/game.provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:verbum_webapp/game/letter.dart';
import 'package:verbum_webapp/game/letter_status.dart';

part 'game_state.g.dart';

typedef GameGrid = List<List<Letter>>;

@JsonSerializable(explicitToJson: true)
class GameState {
  final String word;
  @JsonKey(ignore: true)
  List<String> acceptableWords;
  List<List<Letter>> wordGrid;
  int currentLetter;
  int currentRow;
  bool isOver;
  bool isWon;

  GameState({
    required this.word,
    this.acceptableWords = const [],
    this.wordGrid = const [],
    this.currentLetter = 1,
    this.currentRow = 0,
    this.isOver = false,
    this.isWon = false,
  }) {
    if (wordGrid.isEmpty) {
      _initWordGrid();
    }
  }

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

  Map<String, dynamic> toJson() => _$GameStateToJson(this);

  void _initWordGrid() {
    wordGrid = List.generate(
      numberOfRows,
      (index) => List.generate(
        word.length,
        (index2) {
          if (index == 0) {
            if (index2 == 0) {
              return Letter(letter: word.characters.first, state: LetterStatus.first);
            } else {
              return Letter(state: LetterStatus.tofound);
            }
          } else {
            return Letter();
          }
        },
      ),
    );
  }
}

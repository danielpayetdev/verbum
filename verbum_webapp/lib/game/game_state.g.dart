// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      word: json['word'] as String,
      wordGrid: (json['wordGrid'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>)
                  .map((e) => Letter.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList() ??
          const [],
      currentLetter: json['currentLetter'] as int? ?? 1,
      currentRow: json['currentRow'] as int? ?? 0,
      isOver: json['isOver'] as bool? ?? false,
      isWon: json['isWon'] as bool? ?? false,
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'word': instance.word,
      'wordGrid': instance.wordGrid
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
      'currentLetter': instance.currentLetter,
      'currentRow': instance.currentRow,
      'isOver': instance.isOver,
      'isWon': instance.isWon,
    };

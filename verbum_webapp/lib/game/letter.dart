import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:verbum_webapp/game/letter_status.dart';

part 'letter.g.dart';

@JsonSerializable(includeIfNull: false)
class Letter {
  String? letter;
  LetterStatus? state;
  Letter({Key? key, this.letter, this.state});

  factory Letter.fromJson(Map<String, dynamic> json) => _$LetterFromJson(json);

  Map<String, dynamic> toJson() {
    return _$LetterToJson(this);
  }
}

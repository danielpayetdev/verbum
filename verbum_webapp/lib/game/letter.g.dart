// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Letter _$LetterFromJson(Map<String, dynamic> json) => Letter(
      letter: json['letter'] as String?,
      state: $enumDecodeNullable(_$LetterStatusEnumMap, json['state']),
    );

Map<String, dynamic> _$LetterToJson(Letter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('letter', instance.letter);
  writeNotNull('state', _$LetterStatusEnumMap[instance.state]);
  return val;
}

const _$LetterStatusEnumMap = {
  LetterStatus.first: 'first',
  LetterStatus.typed: 'typed',
  LetterStatus.notInWord: 'notInWord',
  LetterStatus.almostFound: 'almostFound',
  LetterStatus.found: 'found',
  LetterStatus.tofound: 'tofound',
};

import 'models.dart';

class CompletelyWord {
  String? word;
  List<Results>? results;
  Syllables? syllables;
  Pronunciation? pronunciation;
  num? frequency;

  CompletelyWord(
      {this.word = '',
        List<Results>? results,
      this.syllables,
      this.pronunciation,
      this.frequency}): results = results ?? [];

  factory CompletelyWord.fromJson(Map<dynamic, dynamic> json) {
    return CompletelyWord(
      word: json['word'],

      results: json['results'] != null ?(json['results'] as List)
          .map((e) => Results.fromJson(e))
          .toList()
          .cast() : [] ,
      syllables: json['syllables'] != null
          ? Syllables.fromJson(json['syllables'])
          : null,
      pronunciation: json['pronunciation'] != null
          ? (json['pronunciation'] is String )? Pronunciation(all: json['pronunciation']) : Pronunciation.fromJson(json['pronunciation'])
      //some objects come from api as Sting
          : null,
      frequency: json['frequency'] ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (syllables != null) {
      data['syllables'] = syllables!.toJson();
    }
    if (pronunciation != null) {
      data['pronunciation'] = pronunciation!.toJson();
    }
    data['frequency'] = frequency;
    return data;
  }
}

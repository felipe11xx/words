import 'models.dart';

class WordCompleted {
  String? word;
  List<Results>? results;
  Syllables? syllables;
  Pronunciation? pronunciation;
  double? frequency;

  WordCompleted(
      {this.word,
      this.results,
      this.syllables,
      this.pronunciation,
      this.frequency});

  factory WordCompleted.fromJson(Map<String, dynamic> json) {
    return WordCompleted(
      word: json['word'],
      results: (json['results'] as List)
          .map((e) => Results.fromJson(e))
          .toList()
          .cast(),
      syllables: json['syllables'] != null
          ? Syllables.fromJson(json['syllables'])
          : null,
      pronunciation: json['pronunciation'] != null
          ? Pronunciation.fromJson(json['pronunciation'])
          : null,
      frequency: json['frequency'],
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

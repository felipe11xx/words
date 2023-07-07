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

  WordCompleted.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
      });
    }
    syllables = json['syllables'] != null
        ?  Syllables.fromJson(json['syllables'])
        : null;
    pronunciation = json['pronunciation'] != null
        ?  Pronunciation.fromJson(json['pronunciation'])
        : null;
    frequency = json['frequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    if (results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    if (syllables != null) {
      data['syllables'] = syllables!.toJson();
    }
    if (pronunciation != null) {
      data['pronunciation'] =pronunciation!.toJson();
    }
    data['frequency'] = frequency;
    return data;
  }
}





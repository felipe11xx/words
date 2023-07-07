class Results {
  String? definition;
  String? partOfSpeech;
  List<String>? synonyms;
  List<String>? typeOf;
  List<String>? hasTypes;
  List<String>? derivation;
  List<String>? examples;

  Results(
      {this.definition,
      this.partOfSpeech,
      this.synonyms,
      this.typeOf,
      this.hasTypes,
      this.derivation,
      this.examples});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      definition: json['definition'],
      partOfSpeech: json['partOfSpeech'],
      synonyms: json['synonyms'].cast<String>(),
      typeOf: json['typeOf'].cast<String>(),
      hasTypes: json['hasTypes'].cast<String>(),
      derivation: json['derivation'].cast<String>(),
      examples: json['examples'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['partOfSpeech'] = partOfSpeech;
    data['synonyms'] = synonyms;
    data['typeOf'] = typeOf;
    data['hasTypes'] = hasTypes;
    data['derivation'] = derivation;
    data['examples'] = examples;
    return data;
  }
}

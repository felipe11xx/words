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
      List<String>? synonyms,
      List<String>? typeOf,
      List<String>? hasTypes,
      List<String>? derivation,
      List<String>? examples})
      : synonyms = synonyms ?? [],
        typeOf = typeOf ?? [],
        hasTypes = hasTypes ?? [],
        derivation = derivation ?? [],
        examples = examples ?? [];

  factory Results.fromJson(Map<dynamic, dynamic> json) {
    return Results(
      definition: json['definition'],
      partOfSpeech: json['partOfSpeech'],
      synonyms: json["synonyms"] == null
          ? []
          : List<String>.from(json["synonyms"].map((x) => x)),
      typeOf: json["typeOf"] == null
          ? []
          : List<String>.from(json["typeOf"].map((x) => x)),
      hasTypes: json["hasTypes"] == null
          ? []
          : List<String>.from(json["hasTypes"].map((x) => x)),
      derivation: json["derivation"] == null
          ? []
          : List<String>.from(json["derivation"].map((x) => x)),
      examples: json["examples"] == null
          ? []
          : List<String>.from(json["examples"].map((x) => x)),
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

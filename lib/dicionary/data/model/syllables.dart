class Syllables {
  int? count;
  List<String>? list;

  Syllables({this.count, this.list});

  factory Syllables.fromJson(Map<String, dynamic> json) {

    return Syllables(
      count: json['count'],
        list:json['list'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['count'] = count;
    data['list'] = list;
    return data;
  }
}
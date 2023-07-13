class Syllables {
  int? count;
  List<String>? list;

  Syllables({
    this.count,
    List<String>?   list,
  }):list = list ?? [];

  factory Syllables.fromJson(Map<dynamic, dynamic> json) {
    return Syllables(
      count: json['count'],
      list: json['list'] == null ? []: List<String>.from(json["list"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['list'] = list;
    return data;
  }
}

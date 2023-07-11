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

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['count'] = count;
    data['list'] = list;
    return data;
  }
}

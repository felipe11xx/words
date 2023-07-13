class Pronunciation {
  String? all;

  Pronunciation({this.all});

  factory Pronunciation.fromJson(Map<dynamic, dynamic> json) {
    return Pronunciation(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Pronunciation {
  String? all;

  Pronunciation({this.all});

  factory Pronunciation.fromJson(Map<dynamic, dynamic> json) {
    return Pronunciation(
      all: json['all'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['all'] = all;
    return data;
  }
}

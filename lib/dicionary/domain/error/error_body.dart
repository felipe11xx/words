class ErrorBody {
  String? message;
  String? action;

  ErrorBody({this.message, this.action});

  Map<String, dynamic> toMap() {
    return {'message': message, 'action': action};
  }

  factory ErrorBody.fromMap(Map<String, dynamic> map) {
    return ErrorBody(message: map['message'], action: map['action'] ?? "");
  }
}

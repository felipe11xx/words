import 'package:hive/hive.dart';

import '../user_history.dart';

class UserHistoryAdapter extends TypeAdapter<UserHistory> {
  @override
  final int typeId = 0;

  @override
  UserHistory read(BinaryReader reader) {

    final id = reader.readString();
    final list = reader.readStringList();
    return UserHistory(
      userId: id ,
      wordHistory: list,
    );
  }

  @override
  void write(BinaryWriter writer, UserHistory obj) {
    writer.writeString(obj.userId);
    writer.writeStringList(obj.wordHistory);
  }
}
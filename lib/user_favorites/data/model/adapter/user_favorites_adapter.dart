import 'package:hive/hive.dart';

import '../user_favorites.dart';

class UserFavoritesAdapter extends TypeAdapter<UserFavorites> {
  @override
  final int typeId = 1;

  @override
   read(BinaryReader reader) {

    final id = reader.readString();
    final list = reader.readStringList();
    return UserFavorites(
      userId: id ,
      wordsFavorites: list,
    );
  }

  @override
  void write(BinaryWriter writer, UserFavorites obj) {
    writer.writeString(obj.userId);
    writer.writeStringList(obj.wordsFavorites);
  }
}
import 'package:hive/hive.dart';

class MapAdapter extends TypeAdapter<Map<String, dynamic>> {
  @override
  final int typeId = 0; // Assign a unique ID for the adapter

  @override
  Map<String, dynamic> read(BinaryReader reader) {
    final map = reader.readMap();
    return map.cast<String, dynamic>();
  }

  @override
  void write(BinaryWriter writer, Map<String, dynamic> map) {
    writer.writeMap(map);
  }
}
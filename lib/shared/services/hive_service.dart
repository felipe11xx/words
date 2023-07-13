import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {

  static start() async{

    Directory dir = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(dir.path);
  }

  Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  Future<void> closeBox(Box box) async {
    await box.close();
  }

  Future<void> putData(Box box, dynamic key, dynamic value) async {
    await box.put(key, value);
  }

  dynamic getData(Box box, dynamic key) {
    return box.get(key);
  }

  Future<void> deleteData(Box box, dynamic key) async {
    await box.delete(key);
  }
}
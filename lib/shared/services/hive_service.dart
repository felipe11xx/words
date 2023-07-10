import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {

  static start() async{

    Directory dir = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(dir.path);
  }
}
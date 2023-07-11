import 'package:hive/hive.dart';
import 'package:words/shared/services/hive_service.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'dictionary/internal/map_adpter.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await HiveService.start();
  Hive.registerAdapter<Map<String, dynamic>>(MapAdapter());

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}



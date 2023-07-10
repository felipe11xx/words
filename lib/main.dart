import 'package:words/shared/services/hive_service.dart';

import 'app_module.dart';
import 'app_widget.dart';
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

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}



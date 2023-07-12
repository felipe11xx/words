import 'app_module.dart';
import 'app_widget.dart';
import 'firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/shared/services/hive_service.dart';
import 'user_history/data/model/adapter/user_history_adapter.dart';
import 'package:words/user_favorites/data/model/adapter/user_favorites_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await HiveService.start();
  Hive.registerAdapter(UserHistoryAdapter());
  Hive.registerAdapter(UserFavoritesAdapter());

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}



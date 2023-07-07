import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/user_session/presenter/pages/splash_page.dart';

import 'shared/navigation/routes.dart';
import 'shared/resources/strings.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: Strings.wordsApp,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.red,
            cardColor: Colors.grey[200],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

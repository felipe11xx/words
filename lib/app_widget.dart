import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'shared/resources/strings.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            primarySwatch:  AppColors.secondary_light,
            cardColor: AppColors.neutral,
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

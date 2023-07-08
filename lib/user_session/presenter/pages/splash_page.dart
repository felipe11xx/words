import 'package:flutter/material.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:words/shared/theme/typography.dart';
import '../../../shared/navigation/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/resources/strings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 5000), () {

      Modular.to.pushNamed(Routes.dictionary);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
      color: AppColors.secondary_light,
      child:  Center(
        child: Text(Strings.presentation, style: AppTextStyles.headH4.copyWith(color: AppColors.white),textAlign: TextAlign.center,),
      ),
    ));
  }
}

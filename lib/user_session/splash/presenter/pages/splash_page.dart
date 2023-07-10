import 'package:flutter/material.dart';
import 'package:words/shared/theme/colors.dart';
import '../../../../shared/navigation/routes.dart';
import '../../../../shared/resources/strings.dart';
import 'package:words/shared/theme/typography.dart';
import 'package:flutter_modular/flutter_modular.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 1500), () {

      Modular.to.pushReplacementNamed(Routes.signIn);
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

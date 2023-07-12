import '../../cubit/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words/shared/theme/colors.dart';
import '../../../../shared/navigation/routes.dart';
import '../../../../shared/resources/strings.dart';
import 'package:words/shared/theme/typography.dart';
import 'package:flutter_modular/flutter_modular.dart'   hide ModularWatchExtension;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      context.read<SplashCubit>().getUserSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SplashCubit, SplashState>(
            listener: (context, state) {

              if(state is SplashUserSessionSuccessState){
                  Modular.to.pushReplacementNamed(Routes.home);
              }

              if(state is SplashUserSessionErrorState){
                  Modular.to.pushReplacementNamed(Routes.signIn);
              }

            },
            builder: (context, state) {
              return Container(
                color: AppColors.secondary_light,
                child: Center(
                  child: Text(
                    Strings.presentation,
                    style:
                        AppTextStyles.headH4.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }));
  }
}

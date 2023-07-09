import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:words/shared/resources/svg_paths.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:words/shared/theme/typography.dart';
import 'package:words/shared/widgets/app_square_button.dart';

import '../resources/strings.dart';

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({super.key, this.error, this.icon, required this.onPressed, this.buttonText});

  final String? error;
  final String? icon;
  final Function onPressed;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return  ListView(

      physics: const ClampingScrollPhysics() ,
      children: [
        Padding(
        padding: EdgeInsets.only(top: 32.w),
          child: SizedBox(
            child: SvgPicture.asset(
              icon ?? SvgPaths.errorIcon,
              height:300.w,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          child: Text(
            error ?? Strings.genericError,
            textAlign: TextAlign.center,
            style: AppTextStyles.headH3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
          child: Row(
            children: [
              Expanded(
                child:
                AppSquareButton(onTap: () { onPressed(); },
                  textButton: buttonText ?? Strings.tryAgain,
                  color: AppColors.pastelRed,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSquareButton extends StatelessWidget {
  AppSquareButton({
    Key? key,
    this.fit,
    this.icon,
    this.style,
    this.color,
    this.isDisabled = false,
    required this.onTap,
    required this.textButton,

  }) : super(key: key);

  ///ajusta o tipo do texto para perder tamanho caso nao caiba o widget na tela com `BoxFit.scaleDown`.
  Widget? icon;
  TextStyle? style;
  final BoxFit? fit;
  final Color? color;
  final bool isDisabled;
  final String textButton;
  final void Function()? onTap;

  EdgeInsets? _padding;
  TextStyle? _style;


  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Material(
        color: color ?? AppColors.neutral[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Ink(
          child: InkWell(
            onTap: isDisabled == false ? onTap : null,
            child: Padding(
              padding: _padding ?? EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: FittedBox(
                        fit: fit ?? BoxFit.scaleDown,
                        child: Text(
                          textButton,
                          style: style ?? _style,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

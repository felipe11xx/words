import 'package:flutter/material.dart';
import '../../../shared/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordItem extends StatelessWidget {
  const WordItem({super.key, required this.word, required this.onClickItem});

  final String? word;
  final void Function()? onClickItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onClickItem,
        // Modular.to.pushNamed(Routes.wordCompletely,arguments: word);

      child: Padding(
        padding:  EdgeInsets.all(2.w),
        child: Container(
          padding: EdgeInsets.all(8.w),
          width: 50.w,
          height: 50.w,
          decoration:
              BoxDecoration(border: Border.all(color: AppColors.secondaryLight_40, width: 1.w)),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                word ?? '',
                style: AppTextStyles.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
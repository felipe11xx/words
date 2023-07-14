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
        child: Card(
          elevation: 2.w,
          color: AppColors.secondaryLight_20,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              word ?? '',
              style: AppTextStyles.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}

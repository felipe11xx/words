import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words/shared/theme/typography.dart';

import '../../../../shared/navigation/routes.dart';

class WordItem extends StatelessWidget {
  const WordItem({super.key, required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(Routes.wordCompletely,arguments: word);
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        width: 50.w,
        height: 50.w,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1.w)),
        child: Center(
          child: Text(
            word,
            style: AppTextStyles.bodyLarge,
          ),
        ),
      ),
    );
  }
}

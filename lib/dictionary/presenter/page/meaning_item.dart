import 'package:flutter/material.dart';
import '../../../../shared/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeaningItem extends StatelessWidget {
  const MeaningItem({required this.meaning,super.key});

  final String? meaning;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:16.w,right: 16.w),
      child: Text(meaning ?? '', style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.neutral_60),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordItem extends StatelessWidget {
  const WordItem({super.key, required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.w),
        width: 50.w,
        height: 50.w,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1.w)),
        child: Center(child: Text(word)));
  }
}

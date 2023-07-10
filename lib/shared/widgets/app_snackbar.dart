import 'package:flutter/material.dart';
import '../theme/theme.dart';

showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.errorRed,
    duration:const Duration(milliseconds: 10000),
    content: Text(message ?? ''),
  ),);


}
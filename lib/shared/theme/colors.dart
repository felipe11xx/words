import 'package:flutter/material.dart';

class AppColors extends Color {

  static const white = Color(0xffffffff);
  static const transparent = Color(0x00ffffff);
  static const black = Color(0xff000000);
  static const errorRed = Color(0xffDF2E24);
  static const pastelRed = Color(0xffe96d66);
  static const lightRed = Color(0xfffdf2f2);

  static const MaterialColor primary_light = MaterialColor(
    0xff72F951,
    <int, Color>{
      50: Color(0xffffffff),
      100: Color(0xffF3FEF0),
      200: Color(0xffC2FCB4),
      300: Color(0xff9AFB82),
      400: Color(0xff72F951),
      500: Color(0xff6AF149),
      600: Color(0xff62E641),
      700: Color(0xff5AD93A),
    },
  );
  static const MaterialColor secondary_light = MaterialColor(
    0xff00D6C3,
    <int, Color>{
      50: Color(0xffffffff),
      100: Color(0xffDAF7F5),
      200: Color(0xff94EAE3),
      300: Color(0xff4BDFD2),
      400: Color(0xff00D6C3),
      500: Color(0xff03BDAD),
      600: Color(0xff06A697),
      700: Color(0xff088E82),
    },
  );
  static const MaterialColor neutral = MaterialColor(
    0xff76767A,
    <int, Color>{
      50: Color(0xffffffff),
      100: Color(0xffF5F7FA),
      200: Color(0xffD5D5D7),
      300: Color(0xffB6B6B9),
      400: Color(0xff97979B),
      500: Color(0xff76767A),
      600: Color(0xff535355),
      700: Color(0xff373739),
    },
  );

  AppColors(super.value);
}
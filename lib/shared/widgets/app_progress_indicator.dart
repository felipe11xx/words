import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppProgressIndicator extends StatelessWidget {
  double height;
  double width;
  Color color;
  double strokeWidth;

  AppProgressIndicator({super.key, this.color = Colors.white, this.height = 30, this.width = 30, this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    return _progress();
  }
  _progress() {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
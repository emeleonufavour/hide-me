import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Widget? lottie;

  const PageData(
      {this.title,
      this.icon,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.lottie});
}

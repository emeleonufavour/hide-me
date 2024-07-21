import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.title,
      this.style,
      this.textColor,
      this.fontWeight,
      this.fontFamily,
      this.fontSize,
      this.textAlign});

  final String title;
  final TextStyle? style;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ??
          TextStyle(
            color: textColor,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontFamily: fontFamily ?? 'Anton',
            letterSpacing: 0.0,
            fontSize: fontSize ?? 15,
            height: 1.2,
          ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

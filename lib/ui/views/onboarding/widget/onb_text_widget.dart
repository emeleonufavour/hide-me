import 'package:flutter/material.dart';

import '../../../models/page_data.dart';

class OnboardingTextWidget extends StatelessWidget {
  const OnboardingTextWidget({
    super.key,
    required this.page,
    this.style,
  });

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Anton',
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

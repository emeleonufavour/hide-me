import 'package:flutter/material.dart';

import '../../../models/page_data.dart';
import 'onb_text_widget.dart';
import 'page_image.dart';

class OnboardingPage extends StatelessWidget {
  final PageData page;

  const OnboardingPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        space(10),
        PageImage(
          page: page,
          size: 190,
          iconSize: 170,
          lottie: page.lottie,
        ),
        space(8),
        OnboardingTextWidget(
          page: page,
          style: TextStyle(
            fontSize: screenHeight * 0.046,
          ),
        ),
      ],
    );
  }
}

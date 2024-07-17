import 'package:flutter/material.dart';

import '../../../models/page_data.dart';

class PageImage extends StatelessWidget {
  const PageImage(
      {super.key,
      required this.page,
      required this.size,
      required this.iconSize,
      this.lottie});

  final PageData page;
  final double size;
  final double iconSize;
  final Widget? lottie;

  @override
  Widget build(BuildContext context) {
    final bgColor = page.bgColor
        .withBlue(page.bgColor.blue - 40)
        .withGreen(page.bgColor.green + 20)
        .withRed(page.bgColor.red - 100)
        .withAlpha(90);

    final icon1Color =
        page.bgColor.withBlue(page.bgColor.blue - 10).withGreen(220);
    final icon2Color = page.bgColor.withGreen(66).withRed(77);
    final icon3Color = page.bgColor.withRed(111).withGreen(220);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        color: bgColor,
      ),
      child: lottie ??
          Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    page.icon,
                    size: iconSize + 20,
                    color: icon1Color,
                  ),
                ),
                right: -5,
                bottom: -5,
              ),
              Positioned.fill(
                child: RotatedBox(
                  quarterTurns: 5,
                  child: Icon(
                    page.icon,
                    size: iconSize + 20,
                    color: icon2Color,
                  ),
                ),
              ),
              Icon(
                page.icon,
                size: iconSize,
                color: icon3Color,
              ),
            ],
          ),
    );
  }
}

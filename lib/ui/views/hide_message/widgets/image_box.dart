import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/text_widget.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({
    super.key,
    this.fct,
  });

  final VoidCallback? fct;

  @override
  State<ImageBox> createState() => _HomeBoxState();
}

class _HomeBoxState extends State<ImageBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        _controller.forward();
        HapticFeedback.lightImpact();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
          // widget.fct!();
        });
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.maxFinite,
          height: size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/upload.svg",
                  color: Colors.white,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextWidget(
                  title: "Tap to upload an image from gallery",
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

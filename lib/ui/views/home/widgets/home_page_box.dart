import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/text_widget.dart';

class HomePageBox extends StatefulWidget {
  const HomePageBox({
    super.key,
    this.fct,
    required this.boxColors,
    required this.title,
    required this.svgPath,
  });

  final VoidCallback? fct;
  final List<Color> boxColors;
  final String title;
  final String svgPath;

  @override
  State<HomePageBox> createState() => _HomeBoxState();
}

class _HomeBoxState extends State<HomePageBox>
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
      // onTap: () {
      //   _controller.forward();
      //   HapticFeedback.lightImpact();
      //   Future.delayed(const Duration(milliseconds: 200), () {
      //     _controller.reverse();
      //     // widget.fct!();
      //   });
      // },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.maxFinite,
          height: size.height * 0.27,
          padding:
              const EdgeInsets.only(top: 17, left: 17, bottom: 0, right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              tileMode: TileMode.decal,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: widget.boxColors,
            ),
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextWidget(
                title: widget.title,
                textColor: Colors.white,
                fontSize: 25,
                textAlign: TextAlign.left,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: SvgPicture.asset(
                widget.svgPath,
                width: 150,
                height: 150,
                color: Colors.white.withOpacity(0.2),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

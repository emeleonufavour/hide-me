import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hide_me/ui/widgets/text_widget.dart';

class HideMessageScreen extends StatelessWidget {
  const HideMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.decal,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff5c8afd), Color(0xff346dfd)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              width: double.maxFinite,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  children: [SvgPicture.asset("assets/svg/upload.svg")],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

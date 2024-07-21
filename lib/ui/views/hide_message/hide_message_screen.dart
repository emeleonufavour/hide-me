import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hide_me/ui/views/hide_message/widgets/image_box.dart';
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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            ImageBox()
          ]),
        ),
      ),
    );
  }
}

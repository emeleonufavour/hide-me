import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class SeeMessageScreen extends StatelessWidget {
  const SeeMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.decal,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xfff45b56), Color(0xffe32922)],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [TextWidget(title: "Woah")]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/text_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
            colors: [
              Color(0xff13171b),
              Color(0xff325e81),
              Color(0xff13171b),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 19, right: 19),
          child: Column(
            children: [
              const HomePageBox(
                boxColors: [Color(0xff5c8afd), Color(0xff346dfd)],
              ),
              const HomePageBox(
                boxColors: [Color(0xfff45b56), Color(0xffe32922)],
              ),
              SizedBox(
                height: 35,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     TextWidget(
              //       title: "History",
              //       textColor: Colors.white,
              //       fontSize: 22,
              //     ),
              //     TextWidget(
              //       title: "See all",
              //       textColor: Colors.white,
              //     ),
              //   ],
              // )
              SvgPicture.asset(
                "assets/svg/detective.svg",
                width: 100,
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageBox extends StatelessWidget {
  final List<Color> boxColors;
  const HomePageBox({super.key, required this.boxColors});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: double.maxFinite,
        height: size.height * 0.27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            tileMode: TileMode.decal,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: boxColors,
          ),
        ),
      ),
    );
  }
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hide_me/ui/views/hide_message/hide_message_screen.dart';
import 'package:hide_me/ui/views/see_message/see_message_screen.dart';

import '../../widgets/text_widget.dart';
import 'widgets/home_page_box.dart';

List<Widget> homePageContent = [
  const Padding(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: TextWidget(
      title: "What will you like to do today?",
      textColor: Colors.white,
      fontSize: 30,
      textAlign: TextAlign.left,
    ),
  ),
  OpenContainer(
    transitionDuration: const Duration(milliseconds: 400),
    transitionType: ContainerTransitionType.fade,
    openBuilder: (context, closedContainer) => const HideMessageScreen(),
    openColor: const Color(0xff5c8afd),
    closedColor: const Color(0xff346dfd),
    closedShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    closedBuilder: (context, openBuilder) => const HomePageBox(
      boxColors: [Color(0xff5c8afd), Color(0xff346dfd)],
      title: "Hide your secret message in a picture",
      svgPath: "assets/svg/detective.svg",
    ),
  ),
  const SizedBox(
    height: 20,
  ),
  OpenContainer(
    transitionDuration: const Duration(milliseconds: 400),
    transitionType: ContainerTransitionType.fade,
    openBuilder: (context, closedContainer) => const SeeMessageScreen(),
    openColor: const Color(0xfff45b56),
    closedColor: const Color(0xffe32922),
    closedShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    closedBuilder: (context, openBuilder) => const HomePageBox(
      boxColors: [Color(0xfff45b56), Color(0xffe32922)],
      title: "Find out what is hidden in a picture",
      svgPath: "assets/svg/open-box.svg",
    ),
  ),
  const SizedBox(
    height: 35,
  ),
  const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      TextWidget(
        title: "History",
        textColor: Colors.white,
        fontSize: 22,
      ),
      TextWidget(
        title: "See all",
        textColor: Colors.white,
      ),
    ],
  )
];

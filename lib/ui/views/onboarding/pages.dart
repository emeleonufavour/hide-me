import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/page_data.dart';

final pages = [
  PageData(
      icon: Icons.lock,
      title: "Hide your secrets in pictures",
      bgColor: const Color(0xFF0043D0),
      textColor: Colors.white,
      lottie: Lottie.asset("assets/lotties/hide.json",
          animate: true, repeat: true)),
  PageData(
      icon: Icons.format_size,
      title: "See hidden info in pictures",
      textColor: Colors.white,
      bgColor: const Color(0xFFFFA500),
      lottie: Lottie.asset("assets/lotties/reveal.json",
          animate: true, repeat: true)),
  PageData(
      icon: Icons.hdr_weak,
      title: "Let's get started",
      textColor: const Color(0xFF0043D0),
      bgColor: const Color(0xFFFFFFFF),
      lottie: Lottie.asset("assets/lotties/rocket.json",
          animate: true, repeat: true)),
];

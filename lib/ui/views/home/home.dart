import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hide_me/ui/views/home/home_page_content.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _animatedHomePageContent = [];

  @override
  void initState() {
    super.initState();
    for (final widget in homePageContent) {
      _animatedHomePageContent.add(widget);
    }
  }

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
              children: _animatedHomePageContent
                  .map((e) => e
                      .animate()
                      .slideY(
                          begin: 0.5,
                          duration: Duration(
                              milliseconds: 300 *
                                  (_animatedHomePageContent.indexOf(e) + 1)),
                          curve: Curves.easeOut)
                      .fadeIn(
                          begin: 0.1,
                          delay: Duration(
                              milliseconds: 100 *
                                  (_animatedHomePageContent.indexOf(e) + 1))))
                  .toList()),
        ),
      ),
    );
  }
}

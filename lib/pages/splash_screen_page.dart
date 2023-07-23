import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/onboard_Screen_page.dart';

final Color backgroundColor = Colors.black54.withBlue(34);
const Color textColor1 = Colors.white60;
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const OnboardScreenPage();
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child:  AnimatedTextKit(animatedTexts: [
          FadeAnimatedText(
            "Tezma",
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 49,
              color: textColor1,
              letterSpacing: 3
            ),
            fadeInEnd: 1.0,
            fadeOutBegin: 2.0,
            duration: const Duration(seconds: 5)
          )
        ],

        )

      ),
    );
  }
}

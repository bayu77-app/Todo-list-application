import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:to_do_list/screen/todoPage.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/shared/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Center(
                child: LottieBuilder.asset("assets/Lottie/Animation-1740020110966.json"),
              ),
              Center(
                child: Text("Todo List",
                style: WhiteTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: bold,
                ),
                ),
              )
            ],
          ),
        )
      ],
    ), nextScreen: const Todopage(),
    splashIconSize: 400,
    backgroundColor: const Color.fromARGB(255, 114, 143, 206),
    );

  }
}
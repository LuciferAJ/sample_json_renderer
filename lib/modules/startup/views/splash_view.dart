import 'package:flutter/material.dart';
import 'package:sample_json_renderer/utils/constants.dart';
import 'package:sample_json_renderer/utils/media_utils.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          Constants.splashScreenImage,
          height: deviceHeight(context) * 0.25,
        ),
      ),
    );
  }
}

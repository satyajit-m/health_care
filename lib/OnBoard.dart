import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'package:sk_onboarding_screen/sk_onboarding_model.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final pages = [
    SkOnboardingModel(
        title: 'Welcome to R-Health',
        description: 'The Rural Health Companion and Assistant',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/img/art1.png'),
    SkOnboardingModel(
        title: 'Patient Data Collection',
        description:
            'Health Workers collect health updates from individual in rural areas',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/img/doctor4.png'),
    SkOnboardingModel(
        title: 'Check Updates',
        description: 'Individuls can self check health updates in app',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/img/doctor5.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: primaryColor,
        pages: pages,
        skipClicked: (value) {
          Navigator.pushReplacementNamed(context, '/');
        },
        getStartedClicked: (value) {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }
}

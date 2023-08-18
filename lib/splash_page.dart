import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nexus_aura/helper/helper_function.dart';
import 'package:nexus_aura/pages/auth/login_page.dart';
import 'package:nexus_aura/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool _isSignedIn = false; // Add this line

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    getUserLoggedInStatus(); // Call the function to check user's logged-in status
    Timer(
      const Duration(seconds: 3),
      navigateToNextScreen,
    );
  }

  void getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  void navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            _isSignedIn ? const HomePage() : const LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 200,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              "assets/tag.png",
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'home-screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animationController.forward().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale:
              CurvedAnimation(parent: animationController, curve: Curves.ease),
          child: Image.asset(
            'assets/images/pokemon.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

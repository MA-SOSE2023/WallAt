import 'dart:async';
import 'package:flutter/material.dart';
import 'router/router.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  SplashScreen({required this.onInitializationComplete});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    // @TODO - Wait until the database finished loading all the data.
    await Future.delayed(Duration(seconds: 8));

    // Invoke the callback when initialization is complete
    widget.onInitializationComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/dev_debug_images/splash_gif.gif")),
      ),
    );
  }
}

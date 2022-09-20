import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: hard coded splash screen

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Image.asset(Assets.icons.logo.path),
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacementNamed(AppRoutesName.registrationScreen);
  }

  @override
  void initState() {
    _navigateToHome();
    // TODO: implement initState
    super.initState();
  }
}

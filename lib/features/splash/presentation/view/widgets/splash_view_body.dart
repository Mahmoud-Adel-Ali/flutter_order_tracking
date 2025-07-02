import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/services/utils/app_routes.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    // Delay and navigate
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.orderTrackingView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'assets/images/splash.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 18),
            const Text(
              'iTrack Supply',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            const CircularProgressIndicator(color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }
}

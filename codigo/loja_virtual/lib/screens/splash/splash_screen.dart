import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 49, 49, 49),
          child: const Column(
            children: [
              Expanded(
                  child: RiveAnimation.asset('assets/instituto.riv')),
            ],
          ),
        ),
      ),
    );
  }

 // color: const Color.fromARGB(255, 49, 49, 49),

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6)).then((_){
      Navigator.of(context).popAndPushNamed('base');
    });
  }
}


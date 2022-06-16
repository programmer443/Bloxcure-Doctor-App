// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginOptions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const LoginOptions(),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(17, 18, 41, 255),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'WELCOME TO',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    ),
              ),
              const SizedBox(height: 10),
               const Text(
                'Bloxcure',
                style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 15, 235, 209),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 35),
              Image.asset(
                'assets/images/doctor.png',
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

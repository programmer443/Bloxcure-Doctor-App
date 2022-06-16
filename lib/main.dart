import 'package:doctorbloxcure/pages/PatientList.dart';
import 'package:flutter/material.dart';
import 'pages/SplashScreen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor BloxCure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(key: Key('splash_screen')),
      debugShowCheckedModeBanner: false,
    );
  }
}

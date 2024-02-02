import 'package:flutter/material.dart';
import 'package:major_project/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nepali Sign Learn',
      darkTheme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}





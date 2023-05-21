import 'package:flutter/material.dart';
import 'package:born_to_prophecy/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true, // Set debug mode to true
      home: HomeScreen(), // Set HomeScreen as the home screen
    );
  }
}



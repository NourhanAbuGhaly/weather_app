import 'package:flutter/material.dart';
import 'package:weather_app_by_api/screens/loading_screen.dart';
import '../utilities/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: primaryColor,
      ),
      home: const LoadingScreen(),
    );
  }
}
//

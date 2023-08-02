import 'package:flutter/material.dart';
import 'package:weather_app_by_api/screens/location_screen.dart';
import 'package:weather_app_by_api/services/weather.dart';

import 'animated_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  void getLocationWeather() async {
    var weatherData = await WeatherModel().getLocationWeather();
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LocationScreen(weatherData: weatherData)));
    }
  }

  @override
  void initState() {
    getLocationWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: AnimatedRotationImage()));
  }
}
//

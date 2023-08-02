import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app_by_api/screens/city_screen.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  const LocationScreen({super.key, required this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  final WeatherModel _weatherModel = WeatherModel();
  ImageProvider assetImage = const AssetImage('images/location_background.jpg');
  ImageProvider networkImage = const NetworkImage(networkImageLink);

  double temp = 0;
  String description = 'Not Found';
  late String cityName = '';
  late String icon = '';
  int weatherId = 0;

  void infoWeather(var weatherInfo) {
    setState(() {
      if (weatherInfo != null) {
        temp = weatherInfo['main']['temp'];
        cityName = weatherInfo['name'];
        description = _weatherModel.getMessage(temp.toInt());
        weatherId = weatherInfo['weather'][0]['id'];
        icon = _weatherModel.getWeatherIcon(weatherId);
      }
    });
  }

  bool isLoade = false;
  void getImageProvide() {
    networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((_, __) {
      setState(() {
        isLoade = true;
      });
    }));
  }

  @override
  void initState() {
    infoWeather(widget.weatherData);

    getImageProvide();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: !isLoade ? assetImage : networkImage,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.2)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          infoWeather(widget.weatherData);
                        },
                        child: const Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: kSecondaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CityScreen(),
                            ),
                          );
                          infoWeather(result);
                        },
                        child: const Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        icon,
                        style: kTempTextStyle,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${temp.toInt()}',
                            style: kTempTextStyle,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 10),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 7,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                    // shape: BoxShape.circle,
                                    ),
                              ),
                              const Text(
                                'now',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Spartan MB',
                                  letterSpacing: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0, bottom: 120),
                  child: Text(
                    '$description in $cityName',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//

import 'package:flutter/material.dart';
import 'package:weather_app_by_api/services/networking.dart';

import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  String? cityName;
  bool onTap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: assetImg,

            // fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        onTap = true;
                      });
                      cityName = value;
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.location_city),
                      hintText: 'Enter City Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                    ),
                  )),
              TextButton(
                onPressed: () async {
                  var weatherData =
                      await NetworkHelper().getWeatherDataByCityName(cityName!);
                  if (mounted) {
                    Navigator.pop(context, weatherData);
                  }
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Spartan MB',
                      color: onTap ? Colors.white : Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//

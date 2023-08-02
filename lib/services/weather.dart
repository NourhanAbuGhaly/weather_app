

import 'package:weather_app_by_api/services/location.dart';
import 'package:weather_app_by_api/services/networking.dart';

class WeatherModel {
  late double temp;
  late String name;
  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();
    var weatherInfo = await NetworkHelper().getData(location);
    return weatherInfo;
  }

  String getWeatherIcon(int weatherId) {
    print('id $weatherId');
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId < 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
//

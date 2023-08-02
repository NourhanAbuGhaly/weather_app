import 'dart:convert';
import 'package:weather_app_by_api/services/location.dart';
import 'package:http/http.dart';
import '../utilities/constants.dart';

class NetworkHelper {
  Future<dynamic> getData(Location location) async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      print(response.body);
    }
  }

  Future<dynamic> getWeatherDataByCityName(String cityName) async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }
}
//

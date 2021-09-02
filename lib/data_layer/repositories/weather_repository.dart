import 'dart:convert';

import 'package:clima_weather/data_layer/models/fiveday_forecast.dart';
import 'package:clima_weather/data_layer/models/weather.dart';
import 'package:clima_weather/data_layer/repositories/location.dart';
import 'package:clima_weather/data_layer/repositories/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.openweathermap.org/data/2.5/';
const apikey = '71d15ed9cf8ba190378428b971e5f930';
final weatherUrl = (city) => '${baseUrl}weather?q=${city}&appid=${apikey}';
final forecastUrl = (city) => '${baseUrl}forecast?q=${city}&appid=${apikey}';
final getCityUrl = (location) =>
    '${baseUrl}weather?lat=${location.latitude}&lon=${location.longitude}&appid=${apikey}';

class WeatherRepository {
  final http.Client httpClient;
  //constructor
  WeatherRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<Weather> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(getCityUrl(location));
    var weatherData = await networkHelper.getData();
    return Weather.fromJson(weatherData);
  }

  Future<List<Weather>> getWeatherFromCities(List<String> cities) async {
    List<Weather> weathers = new List<Weather>();
    await Future.wait(
            cities.map((city) => this.httpClient.get(weatherUrl(city))))
        .then((response) {
      response.forEach((element) {
        weathers.add(Weather.fromJson(jsonDecode(element.body)));
      });
      return response;
    });
    return weathers;
  }

  Future<List<FiveDayForeCast>> getforecastOfCity(String city) async {
    final response = await this.httpClient.get(forecastUrl(city));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from city: ${city}');
    }
    var forecastJson = jsonDecode(response.body);
    var f = ForeCast.fromJson(forecastJson);
    return f.fiveDayForeCastList;
  }
}

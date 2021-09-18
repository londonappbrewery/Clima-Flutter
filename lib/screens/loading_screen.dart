import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:weather/weather.dart';
import 'package:clima/services/api.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String key = api_key;
  @override
  void initState() {
    super.initState();
  }

  void getLocationAndWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    WeatherFactory wf = WeatherFactory(key);
    Weather w = await wf.currentWeatherByLocation(
        location.latitude, location.longitude);
    print(w);
  }

  @override
  Widget build(BuildContext context) {
    getLocationAndWeather();
    return Scaffold();
  }
}

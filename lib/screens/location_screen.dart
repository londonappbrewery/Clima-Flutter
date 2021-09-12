import 'dart:io';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  var condition;
  AssetImage _imageToShow;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    _imageToShow = AssetImage('images/tree.jpg');
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = "Error";
        weatherMessage = "Unable to get weather data";
        cityName = '$cityName';
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];

      updateimage();
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to exit the App"),
              actions: [
                ElevatedButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                ElevatedButton(
                  child: Text("Yes"),
                  onPressed: () => exit(0),
                ),
              ],
            ));
  }

  void updateimage() {
    setState(() {
      if (condition < 300) {
        _imageToShow = AssetImage('images/city_background.png');
      } else if (condition < 400) {
        _imageToShow = AssetImage('images/rain.jpg');
      } else if (condition < 700) {
        _imageToShow = AssetImage('images/snowfall.jpg');
      } else if (condition == 800) {
        _imageToShow = AssetImage('images/sunny.jpg');
      } else if (condition <= 804) {
        _imageToShow = AssetImage('images/tree.jpg');
      } else {
        _imageToShow = AssetImage('images/sky.jpg');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageToShow,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(.6), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: kTextFieldInputDecoration,
                          onChanged: (value) {
                            cityName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(.1),
                        ),
                        onPressed: () async {
                          if (cityName != null) {
                            var weatherData =
                                await weather.getCityWeather(cityName);
                            updateUI(weatherData);
                            setState(() {
                              updateimage();
                            });
                          }
                        },
                        child: Text(
                          'Get Weather',
                          style: kButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '$temperature°',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherIcon,
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 15.0,
                        ),
                        child: Text(
                          '$weatherMessage in $cityName',
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var weatherData = await weather.getLocationWeather();
          updateUI(weatherData);
        },
        child: const Icon(Icons.navigation, color: Colors.white),
        backgroundColor: Colors.black,
      ),
    );
  }
}

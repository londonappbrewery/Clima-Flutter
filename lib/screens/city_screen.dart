import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/qq.gif'),
              fit: BoxFit.contain,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) {
                        return LocationScreen();
                      }));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: TextField(
                      decoration: kTextFieldInputDecoration,
                      onChanged: (value) {
                        cityName = value;
                      },
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                      child: Text(
                      'Get Weather',
                      style: kButtonTextStyle,
                    ),
                    onPressed: () {
                      Navigator.pop(context, cityName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

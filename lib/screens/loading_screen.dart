import 'package:my_meteo/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:my_meteo/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// const apiKey = 'bdc1f0911127ae9b04c8d65b7e45cb9d';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var forecastData = await WeatherModel().getLocationForecast();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            locationWeather: weatherData,
            locationForecast: forecastData,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

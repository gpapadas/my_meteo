import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_meteo/services/weather.dart';
import 'package:my_meteo/utilities/constants.dart';
import 'package:my_meteo/screens/navigation_screen.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String weatherIcon;
  String weatherMessage;
  String cityName;
  String description;
  String sunrise;
  String sunset;
  int intSun;
  String inWord = 'in ';

  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        inWord = '';
        return;
      }
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      description = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];

      var sunriseUnix = weatherData['sys']['sunrise'];
      var sunsetUnix = weatherData['sys']['sunset'];
      sunrise = DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(sunriseUnix * 1000));
      sunset = DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationScreen(),
      appBar: AppBar(
        title: Text('My Meteo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search for other cities weather
              // ...
            },
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/location_background.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   ),
        // ),
        // constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(
                      '$cityName',
                      style: kMessageTextStyle,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Icon(
                      Icons.wb_sunny,
                      size: 20.0,
                    ),
                    Icon(
                      Icons.arrow_drop_up,
                      size: 20.0,
                    ),
                    Text('$sunrise', style: kTimeTextStyle),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 20.0,
                    ),
                    Text('$sunset', style: kTimeTextStyle),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'images/$weatherIcon',
                    color: Colors.white,
                    width: 150.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$description',
                        style: kMessageTextStyle,
                      ),
                    ],
                  )
                ],
              ),

              // Padding(
              //   padding: EdgeInsets.only(left: 15.0),
              //   child: Text(
              //     '$description',
              //     style: kMessageTextStyle,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(right: 15.0),
              //   child: Text(
              //     '$weatherMessage in $cityName!',
              //     textAlign: TextAlign.right,
              //     style: kMessageTextStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

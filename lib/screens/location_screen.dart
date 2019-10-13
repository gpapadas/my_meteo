import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_meteo/services/weather.dart';
import 'package:my_meteo/utilities/constants.dart';
import 'package:my_meteo/screens/navigation_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.locationForecast});

  final locationWeather;
  final locationForecast;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // Weather variables
  int temperature;
  String weatherIcon;
  String cityName;
  String description;
  String sunrise;
  String sunset;

  // Forecast variables
  double tempMin;
  double tempMax;

  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather, widget.locationForecast);
  }

  void updateUI(dynamic weatherData, dynamic forecastData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
        return;
      }

      // Current weather data.
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();

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

      // Hourly forecast data.
      //dt = Time of data forecasted, unix, UTC
      for (var forecast in forecastData['list']) {
        tempMin = forecast['main']['temp_min'].toDouble();
        tempMax = forecast['main']['temp_max'].toDouble();
      }
      //double tempMin = forecastData['list'][0]['main']['temp_min'].toDouble();
      
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
              // TODO: Search for other cities weather
              // ...
            },
          ),
        ],
      ),
      body: Container(
        // TODO: In case I decide to have background image instead of color

        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/location_background.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   ),
        // ),
        // constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
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
                          width: 15.0,
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
                        width: 170.0,
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
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          'images/$weatherIcon',
                          color: Colors.white,
                          width: 50.0,
                        ),
                        Text('25'),
                        Text('18'),
                      ],
                    ),
                  ],
                )
                // child: Column(
                //   children: <Widget>[
                //     Text('Hourly forecast list'),
                //   ],
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

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
  double windSpeed;
  String sunrise;
  String sunset;

  // Forecast variables
  int forecastsCount;
  List<String> forecastIcon = [];
  List<int> fTemp = [];
  List<String> fTime = [];
  List<String> fDay = [];

  // It has to be glogal so we can use it in _buildForecast().
  // dynamic forecastData;

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

      // Current weather data
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();

      var sunriseUnix = weatherData['sys']['sunrise'];
      var sunsetUnix = weatherData['sys']['sunset'];

      sunrise = DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(sunriseUnix * 1000));
      sunset = DateFormat('hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000));

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition, sunsetUnix, sunriseUnix);

      description = weatherData['weather'][0]['description'];
      windSpeed = weatherData['wind']['speed'].toDouble();
      cityName = weatherData['name'];

      // 5 day / 3 hour forecast data
      forecastsCount = forecastData['list'].length;

      for (var forecast in forecastData['list']) {
        fTemp.add(forecast['main']['temp'].toDouble().toInt());
        forecastIcon.add(weather.getForecastIcon(forecast['weather'][0]['id']));
        fTime.add(DateFormat('hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000)));
        fDay.add(DateFormat('E').format(
            DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000)));
      }
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
        // TODO: The following commented code is for just in case
        // I decide to have background image instead of color
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('now'),
                            SizedBox(
                          height: 10.0,
                        ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 18.0,
                                ),
                                Text(
                                  '$cityName',
                                  style: kMessageTextStyle,
                                ),
                              ],
                            ),
                          ],
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
                          Text(
                            '$windSpeed m/s',
                            style: kMessageTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            _buildForecast(forecastsCount),
          ],
        ),
      ),
    );
  }

  // Returns a list with 5 day / 3 hour forecast data
  Widget _buildForecast(int forecasts) {
    //int temperature = forecasts[index]['main']['temp'].toDouble().toInt();

    return Expanded(
      flex: 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecasts,
          itemBuilder: (context, index) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fDay[index],
                  style: TextStyle(fontSize: 10.0),
                ),
                Text(
                  fTime[index],
                  style: TextStyle(fontSize: 10.0),
                ),
                SvgPicture.asset(
                  'images/${forecastIcon[index]}',
                  color: Colors.white,
                  width: 50.0,
                ),
                Text('${fTemp[index]}°'),
                //Text('${forecasts[index]['main']['temp_min'].toDouble().toInt()}'),
              ],
            );
          }),
      // child: Column(
      //   children: <Widget>[
      //     Text('Hourly forecast list'),
      //   ],
      // ),
    );
  }
}

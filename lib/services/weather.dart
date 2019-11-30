import 'package:intl/intl.dart';
import 'package:my_meteo/services/location.dart';
import 'package:my_meteo/services/networking.dart';
import 'package:my_meteo/utilities/apikey.dart';

const apiURLWeather = 'https://api.openweathermap.org/data/2.5/weather';
const apiURLForecast = 'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper =
        NetworkHelper('$apiURLWeather?q=$city&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$apiURLWeather?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationForecast() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$apiURLForecast?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    var forecastData = await networkHelper.getData();

    return forecastData;
  }

  String getWeatherIcon(int condition, dynamic sunsetUnix, dynamic sunriseUnix) {
    DateTime now = DateTime.now();
    DateTime sunset =
        new DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000);
    DateTime sunrise =
        new DateTime.fromMillisecondsSinceEpoch(sunriseUnix * 1000);

    bool isDayLight = now.isBefore(sunset) && now.isAfter(sunrise);

    if (condition >= 300 && condition < 500) {
      return 'Cloud-Rain-Alt.svg';
    } else if (condition == 500) {
      return 'Cloud-Rain-Sun-Alt.svg';
    } else if (condition > 500 && condition < 600) {
      return 'Cloud-Rain.svg';
    } else if (condition == 600) {
      return 'Cloud-Snow-Alt.svg';
    } else if (condition > 600 && condition < 700) {
      return 'Cloud-Snow.svg';
    } else if (condition == 800) {
      return isDayLight ? 'Sun.svg' : 'Moon.svg';
    } else if (condition >= 801 && condition < 803) {
      return isDayLight ? 'Cloud-Sun.svg' : 'Cloud-Moon.svg';
    } else if (condition >= 803 && condition <= 804) {
      return 'Cloud.svg';
    }
    return 'Sun.svg';
  }
}

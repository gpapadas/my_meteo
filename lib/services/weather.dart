import 'package:my_meteo/services/location.dart';
import 'package:my_meteo/services/networking.dart';
import 'package:my_meteo/utilities/apikey.dart';

const apiURLWeather = 'https://api.openweathermap.org/data/2.5/weather';
const apiURLForecast = 'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {

  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$apiURLWeather?q=$city&appid=$kApiKey&units=metric');

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

  String getWeatherIcon(int condition) {
    if (condition >= 500 && condition < 600) {
      return 'Cloud-Rain.svg';
    } else if (condition >= 600 && condition < 700) {
      return 'Cloud-Snow.svg';
    } else if (condition == 800) {
      return 'Sun.svg';
    } else if (condition == 801) {
      return 'Cloud.svg';
    }
    return 'Sun.svg';
  }
}

import 'package:my_meteo/services/location.dart';
import 'package:my_meteo/services/networking.dart';
import 'package:my_meteo/utilities/apikey.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$city&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
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

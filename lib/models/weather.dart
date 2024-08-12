import 'package:country_code_picker/country_code.dart';

class Weather {
  final Map<String, dynamic> coord;
  final String weather;
  final String weatherDescription;
  final num windSpeed;
  final num seaLevel;
  final num temperature;
  final String cityName;
  final String icon;
  final String country;
  final String code;

  Weather({
    required this.coord,
    required this.weather,
    required this.weatherDescription,
    required this.windSpeed,
    required this.seaLevel,
    required this.cityName,
    required this.temperature,
    required this.icon,
    required this.country,
    required this.code,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weather: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      coord: json['coord'],
      cityName: json['name'],
      seaLevel: json['main']['sea_level'],
      windSpeed: json['wind']['speed'],
      temperature: json['main']['temp'] - 273.15,
      icon: json['weather'][0]['icon'],
      code: json['sys']['country'].toString().toLowerCase(),
      country: CountryCode.fromCountryCode(json['sys']['country']).name!,
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/location_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weatherData;
  Future<Weather?>? _weatherDataFuture;

  Future<Weather?> getWeatherData() {
    if (_weatherDataFuture == null) {
      _weatherDataFuture = _fetchWeatherData();
    }
    return _weatherDataFuture!;
  }

  Future<void> getWeatherDataFromCityName({required String name}) async {
    _weatherDataFuture = _fetchWeatherDataFromCityName(name);
    notifyListeners();
  }

  Future<Weather?> _fetchWeatherData() async {
    try {
      final Position pos = await LocationService().getLocation();
      Dio dio = Dio();
      final res = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${pos.latitude}&lon=${pos.longitude}&appid=541341a2ab274555412620fafc0b5a3a",
      );
      _weatherData = Weather.fromJson(res.data);
      return _weatherData;
    } catch (e) {
      print(e);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<Weather?> _fetchWeatherDataFromCityName(String name) async {
    try {
      final Location? pos = await LocationService().getPosition(cityName: name);
      Dio dio = Dio();
      final res = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${pos!.latitude}&lon=${pos.longitude}&appid=541341a2ab274555412620fafc0b5a3a",
      );
      _weatherData = Weather.fromJson(res.data);
      return _weatherData;
    } catch (e) {
      print(e);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Weather? get weatherData => _weatherData;
}

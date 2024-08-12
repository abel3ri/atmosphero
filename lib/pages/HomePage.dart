import 'package:flutter/material.dart' hide DataRow;
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/text_field_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/DataRow.dart';
import 'package:weather_app/widgets/ShimmerLoading.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final textFieldProvider = Provider.of<TextFieldProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color.fromRGBO(0, 0, 0, 0),
        title: TextField(
          controller: textFieldProvider.controller,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "Enter city name",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            filled: true,
            contentPadding: EdgeInsets.all(12),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (textFieldProvider.controller.text.isNotEmpty) {
                weatherProvider.getWeatherDataFromCityName(
                  name: textFieldProvider.controller.text,
                );
              }
            },
            icon: Icon(
              Icons.search,
              size: 36,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Weather?>(
        future: weatherProvider.getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmerloading();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error loading content"),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No data available"),
            );
          }

          final weatherData = snapshot.data!;
          print(weatherData.country);

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        weatherData.cityName.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      DataRow(label: "country", value: weatherData.country),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Image.network(
                        "https://flagcdn.com/w320/${weatherData.code}.png",
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        '${weatherData.temperature.toStringAsFixed(2)}℃',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      DataRow(
                        label: "weather condition",
                        value: weatherData.weather,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      DataRow(
                          label: "wind speed",
                          value: '${weatherData.windSpeed} m/s'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      DataRow(
                          label: "sea level",
                          value: '${weatherData.seaLevel} m'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Image.network(
                        "http://openweathermap.org/img/wn/${weatherData.icon}@2x.png",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

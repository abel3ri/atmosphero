import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/HomePage.dart';
import 'package:weather_app/providers/text_field_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TextFieldProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          textTheme: GoogleFonts.quicksandTextTheme(),
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          textTheme: GoogleFonts.quicksandTextTheme(),
        ),
        themeMode: ThemeMode.system,
        home: HomePage(),
      ),
    ),
  );
}

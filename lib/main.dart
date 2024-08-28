import 'package:flutter/material.dart';
import 'package:movies_app/constants/my_theme_data.dart';
import 'package:movies_app/screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies App",
      theme: MyThemeData.lightTheme,
      initialRoute: HomeScreen.route_Name,
      routes: {
        HomeScreen.route_Name: (context) => HomeScreen(),
      },
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/my_theme_data.dart';
import 'package:movies_app/screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAWPigFUSbiGIoLnDx0NwUfKIUJgXc9Mt4",
          appId: "com.example.movies_app",
          messagingSenderId: "205860268141",
          projectId: "movies-app-2a577"))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
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
        HomeScreen.route_Name: (context) => const HomeScreen(),
      },
    );
  }
} 

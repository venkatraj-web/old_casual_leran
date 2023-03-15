import 'dart:async';

import 'package:casual/screens/login_screen.dart';
import 'package:casual/screens/splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? status;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }


}

_checkAuth(BuildContext context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final String? token = await _prefs.getString('token');
  if (token != null) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

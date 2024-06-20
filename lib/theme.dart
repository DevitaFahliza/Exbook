import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  primaryColor: Color(0xFFFF5722),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    headline1: TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(color: Colors.black, fontSize: 16),
  ),
);

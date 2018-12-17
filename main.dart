import 'package:flutter/material.dart';
import 'homescreen.dart';


void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        accentColor: Colors.blue
      ),
      title: 'FlashIt',
     // home: MyApp(),
      home: HomeScreen(false),
  ));
}


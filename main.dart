import 'package:flutter/material.dart';
import 'homescreen.dart';


void main() {
  runApp(MaterialApp(
      theme: ThemeData(     //edit brightness here
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        accentColor: Colors.blue
      ),
      title: 'FlashIt',
      home: HomeScreen(),
  ));
}
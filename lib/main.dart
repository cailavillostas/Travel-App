import 'package:flutter/material.dart';
import 'package:project/MyApp.dart';
import 'package:project/WelcomePage.dart';
import 'AccomplishedTripsPage.dart';

void main() {
  runApp(TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel Itinerary',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:nominatim/listNames.dart';
import 'package:nominatim/location/Location_Autocomplete.dart';
import 'package:nominatim/models/place_model.dart';
import 'package:nominatim/screens/source_target_page.dart';
import 'dart:async';
import './models/nominatim_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Search Bar with Suggestions'),
          ),
          body: SourceTargetPage()),
    );
  }
}

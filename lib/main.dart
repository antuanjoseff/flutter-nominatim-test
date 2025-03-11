import 'package:flutter/material.dart';
import 'package:nominatim/screens/source_target_page.dart';
import 'package:nominatim/widgets/days_picker.dart';

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
          body: Center(
            child: SizedBox(
              width: 650,
              child: Column(
                children: [SourceTargetPage(), DaysPicker()],
              ),
            ),
          )),
    );
  }
}

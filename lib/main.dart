import 'package:flutter/material.dart';
import 'package:nominatim/models/place_model.dart';
import 'package:nominatim/models/trip.dart';
import 'package:nominatim/screens/source_target_page.dart';
import 'package:nominatim/widgets/days_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, Place> origin_source = {};
  bool enableButton = false;

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
                children: [
                  SourceTargetPage(onCompleted: (Map<String, Place> ruta) {
                    origin_source = ruta;
                    debugPrint('Ruta omplerta $ruta');
                    setState(() {
                      enableButton = true;
                    });
                  }),
                  DaysPicker(onChange: (value) {
                    debugPrint('I am in the main file $value');
                  }),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: enableButton ? () {} : null,
                    child: Text('Enviar'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nominatim/listNames.dart';
import 'package:nominatim/models/place_model.dart';
import 'dart:async';
import './models/nominatim_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NominatimWidget(title: 'Flutter Demo Home Page'),
    );
  }
}

class NominatimWidget extends StatefulWidget {
  const NominatimWidget({super.key, required this.title});

  final String title;

  @override
  State<NominatimWidget> createState() => _NominatimWidgetState();
}

class _NominatimWidgetState extends State<NominatimWidget> {
  final myController = TextEditingController();
  Timer? _debounce;
  NominatimModel nominatim = NominatimModel();
  List<Place> places = [];
  int numPlaces = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Origen'),
              TextFormField(
                controller: myController,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce =
                      Timer(const Duration(milliseconds: 500), () async {
                    // places = await nominatim.fetchPlaces(value);
                    setState(() {
                      name = value;
                      debugPrint('$name');
                    });
                  });
                },
              ),
              Text('$name  ${name == ''}'),
              name != '' ? Card(child: ListNames(search: name)) : Container()
            ],
          ),
        ),
      ),
    );
  }
}

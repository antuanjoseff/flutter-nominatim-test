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
      debugShowCheckedModeBanner: false,
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
  TextEditingController mySourceController = TextEditingController();
  TextEditingController myTargetController = TextEditingController();
  Timer? _debounce;
  NominatimModel nominatim = NominatimModel();
  List<Place> sources = [];
  List<Place> targets = [];
  int numPlaces = 0;
  bool sourceListVisible = true;
  bool targetListVisible = true;
  bool searchingSource = false;
  bool searchingTarget = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mySourceController.dispose();
    myTargetController.dispose();
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
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon:
                      searchingSource ? CircularProgressIndicator() : null,
                ),
                controller: mySourceController,
                onTap: () {
                  mySourceController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: mySourceController.value.text.length);
                  setState(() {
                    sourceListVisible = true;
                    targetListVisible = false;
                  });
                },
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce =
                      Timer(const Duration(milliseconds: 500), () async {
                    setState(() {
                      searchingSource = true;
                    });
                    sources = await nominatim.fetchPlaces(value);
                    setState(() {
                      searchingSource = false;
                    });
                  });
                },
              ),
              sources.isNotEmpty
                  ? Column(children: [
                      ListNames(
                          data: sources,
                          textController: mySourceController,
                          visible: sourceListVisible)
                    ])
                  : Container(),
              Text('Destí'),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon:
                      searchingTarget ? CircularProgressIndicator() : null,
                ),
                controller: myTargetController,
                onTap: () {
                  myTargetController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: myTargetController.value.text.length);
                  setState(() {
                    sourceListVisible = false;
                    targetListVisible = true;
                  });
                },
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce =
                      Timer(const Duration(milliseconds: 300), () async {
                    setState(() {
                      searchingTarget = true;
                    });
                    targets = await nominatim.fetchPlaces(value);
                    setState(() {
                      searchingTarget = false;
                    });
                  });
                },
              ),
              targets.isNotEmpty
                  ? Column(children: [
                      ListNames(
                          data: targets,
                          textController: myTargetController,
                          visible: targetListVisible)
                    ])
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nominatim/models/nominatim_model.dart';
import 'package:nominatim/models/place_model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class LocationAutocomplete extends StatefulWidget {
  const LocationAutocomplete({super.key});

  @override
  State<LocationAutocomplete> createState() => _LocationAutocompleteState();
}

class _LocationAutocompleteState extends State<LocationAutocomplete> {
  Timer? _debounce;
  NominatimModel nominatim = NominatimModel();

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  final SearchController = TextEditingController();
  var uuid = const Uuid();
  List<Place> listOfLocation = [];

  @override
  void initState() {
    SearchController.addListener(() {
      _onChange();
    });
    super.initState();
  }

  _onChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      listOfLocation = await nominatim.fetchPlaces(SearchController.text);

      setState(() {});
    });
    // placeSuggestion(SearchController.text);
  }

  void placeSuggestion(String input) async {
    const String apiKey = "";
    try {
      String bassedUrl =
          "https://sigserver4.udg.edu/apps/carpool/api/search/municipality/$input?format=json";

      String request = '$bassedUrl';

      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body);
          debugPrint('$listOfLocation');
        });
      } else {
        throw Exception("Fail to load");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Location autocomplete',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: SearchController,
                decoration: InputDecoration(hintText: 'Search place...'),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Visibility(
                visible: SearchController.text.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listOfLocation.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {},
                            child: ListTile(
                              title: Text(
                                listOfLocation[index].name,
                              ),
                            ));
                      }),
                ),
              ),
              Visibility(
                visible: SearchController.text.isEmpty,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.my_location, color: Colors.green),
                          SizedBox(
                            width: 10,
                          ),
                          Text("My Location",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ))
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}

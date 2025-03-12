import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nominatim/models/nominatim_model.dart';
import 'package:nominatim/models/place_model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class LocationAutocomplete extends StatefulWidget {
  LocationAutocomplete(
      {super.key,
      this.placeHolder,
      this.onUnfoldChanges,
      required this.onChanged});

  Function? onUnfoldChanges;
  Function onChanged;
  String? placeHolder;
  @override
  State<LocationAutocomplete> createState() => _LocationAutocompleteState();
}

class _LocationAutocompleteState extends State<LocationAutocomplete> {
  Timer? _debounce;
  bool selectedSuggestion = false;
  bool suggestionsVisible = true;

  late FocusScopeNode _focusNode;
  NominatimModel nominatim = NominatimModel();

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
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

    _focusNode = FocusScopeNode();
    super.initState();
  }

  _onChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (SearchController.text.length < 4) {
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      if (!selectedSuggestion) {
        listOfLocation = await nominatim.fetchPlaces(SearchController.text);
        statusChanged(suggestionsVisible);
        setState(() {});
      } else {
        selectedSuggestion = false;
      }
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
    const closed = true;
    const open = false;

    return Padding(
      padding: EdgeInsets.all(15),
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyUpEvent) {
            if (event.physicalKey == PhysicalKeyboardKey.enter) {
              SearchController.selection =
                  TextSelection.collapsed(offset: SearchController.text.length);
              // widget.onSelected();
              return KeyEventResult.handled;
            }
            if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
              node.nextFocus();
              return KeyEventResult.handled;
            }
            if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
              node.previousFocus();
              return KeyEventResult.handled;
            }
            if (event.physicalKey == PhysicalKeyboardKey.escape) {
              setState(() {
                SearchController.text = '';
                listOfLocation = [];
                statusChanged(!suggestionsVisible);
                widget.onChanged(null);
              });

              return KeyEventResult.handled;
            }
          }

          return KeyEventResult.ignored;
        },
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.circle_outlined, color: Colors.orange, size: 15),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: SearchController,
                    decoration: InputDecoration(
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.grey[300] ?? Colors.grey),
                      ),
                      hintText: widget.placeHolder,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: widget.placeHolder,
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            // LIST OF SEARCH RESULTS
            Visibility(
              visible: SearchController.text.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: listOfLocation.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              SearchController.text =
                                  listOfLocation[index].name;
                              widget.onChanged(listOfLocation[index]);
                              selectedSuggestion = true;

                              statusChanged(closed);

                              setState(() {
                                listOfLocation = [];
                              });
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listOfLocation[index].name,
                                  ),
                                  Icon(Icons.location_on),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void statusChanged(bool status) {
    if (widget.onUnfoldChanges != null) {
      widget.onUnfoldChanges!(status);
    }
  }
}

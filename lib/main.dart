import 'package:flutter/material.dart';
import 'package:nominatim/listNames.dart';
import 'package:nominatim/models/place_model.dart';
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
        body: Center(
          child: SearchBar(),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int _selectedIndex = -1;
  NominatimModel nominatim = NominatimModel();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _selectedIndex = -1;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return _suggestions
              .where((String suggestion) => suggestion
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()))
              .toList();
        },
        onSelected: (String selectedValue) {
          print('Selected: $selectedValue');
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          _focusNode = focusNode;
          _searchController = controller;
          return TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (String value) {
              // Add any additional logic when text changes
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () async {
                List<Place> temp = await nominatim.fetchPlaces(value);
                if (temp.isEmpty) {
                  _suggestions = [];
                } else {
                  temp.forEach((e) {
                    _suggestions.add(e.name);
                  });
                }

                debugPrint('Suggestions $_suggestions');
                setState(() {});
              });
            },
            onSubmitted: (String value) {
              // Add any logic when the user submits the search
              onFieldSubmitted();
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return InkWell(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Builder(builder: (BuildContext context) {
                        final bool highlight =
                            AutocompleteHighlightedOption.of(context) == index;
                        // if (highlight) {
                        //   SchedulerBinding.instance
                        //       .addPostFrameCallback((Duration timeStamp) {
                        //     Scrollable.ensureVisible(context, alignment: 0.5);
                        //   });
                        // }
                        return Container(
                          color:
                              highlight ? Theme.of(context).focusColor : null,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(option),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> _suggestions = [];
}

import 'package:flutter/material.dart';
import 'package:nominatim/location/Location_Autocomplete.dart';

class SourceTargetPage extends StatefulWidget {
  const SourceTargetPage({super.key});

  @override
  State<SourceTargetPage> createState() => _SourceTargetPageState();
}

class _SourceTargetPageState extends State<SourceTargetPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  LocationAutocomplete(
                    placeHolder: 'Origen...',
                  ),
                  LocationAutocomplete(
                    placeHolder: 'Destí...',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

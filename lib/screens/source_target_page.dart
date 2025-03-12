import 'package:flutter/material.dart';
import 'package:nominatim/location/Location_Autocomplete.dart';
import 'package:nominatim/models/place_model.dart';

class SourceTargetPage extends StatefulWidget {
  const SourceTargetPage({super.key});

  @override
  State<SourceTargetPage> createState() => _SourceTargetPageState();
}

class _SourceTargetPageState extends State<SourceTargetPage> {
  bool switcher = true;
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
                      onUnfoldChanges: (bool unfolded) {
                        setState(() {
                          switcher = !unfolded;
                        });
                      },
                      onSelected: (Place place) {
                        debugPrint(
                            'Place ${place.pk} ${place.name} ${place.codi}');
                      }),
                  if (switcher)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.swap_vert),
                      ],
                    ),
                  LocationAutocomplete(
                      placeHolder: 'Destí...',
                      onUnfoldChanges: (bool unfolded) {
                        setState(() {
                          switcher = !unfolded;
                        });
                      },
                      onSelected: (Place place) {
                        debugPrint(
                            'Place ${place.pk} ${place.name} ${place.codi}');
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

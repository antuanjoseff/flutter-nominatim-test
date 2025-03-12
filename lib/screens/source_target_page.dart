import 'package:flutter/material.dart';
import 'package:nominatim/location/Location_Autocomplete.dart';
import 'package:nominatim/models/place_model.dart';

class SourceTargetPage extends StatefulWidget {
  const SourceTargetPage({super.key});

  @override
  State<SourceTargetPage> createState() => _SourceTargetPageState();
}

class _SourceTargetPageState extends State<SourceTargetPage> {
  bool switcherOn = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(alignment: Alignment(-0.97, 0), children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  LocationAutocomplete(
                      placeHolder: 'Origen...',
                      onUnfoldChanges: (bool unfolded) {
                        setState(() {
                          switcherOn = !unfolded;
                        });
                      },
                      onSelected: (Place place) {
                        debugPrint(
                            'Place ${place.pk} ${place.name} ${place.codi}');
                      }),
                  LocationAutocomplete(
                      placeHolder: 'Destí...',
                      onUnfoldChanges: (bool unfolded) {
                        setState(() {
                          switcherOn = !unfolded;
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
          if (switcherOn)
            Tooltip(
              message: 'Switch',
              child: ElevatedButton(
                  onPressed: () {},
                  clipBehavior: Clip.none,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    elevation: 0,
                  ),
                  child: Icon(Icons.swap_vert_circle,
                      size: 40, color: Colors.blue)),
            ),
        ]),
      ],
    );
  }
}

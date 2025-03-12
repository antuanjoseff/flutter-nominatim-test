import 'package:flutter/material.dart';
import 'package:nominatim/location/Location_Autocomplete.dart';
import 'package:nominatim/models/place_model.dart';
import '../models/trip.dart';

class SourceTargetPage extends StatefulWidget {
  Function onCompleted;
  SourceTargetPage({super.key, required this.onCompleted});

  @override
  State<SourceTargetPage> createState() => _SourceTargetPageState();
}

class _SourceTargetPageState extends State<SourceTargetPage> {
  bool switcherOn = true;

  Map<String, Place> route_source = {};
  Place? routeSource;
  Place? routeTarget;

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
                      onChanged: (Place? place) {
                        if (place != null) {
                          route_source['source'] = place;
                          if (routeIsComplete(route_source)) {
                            widget.onCompleted(route_source);
                          }
                        }
                      }),
                  LocationAutocomplete(
                      placeHolder: 'Destí...',
                      onUnfoldChanges: (bool unfolded) {
                        setState(() {
                          switcherOn = !unfolded;
                        });
                      },
                      onChanged: (Place? place) {
                        if (place != null) {
                          route_source['target'] = place;
                          if (routeIsComplete(route_source)) {
                            widget.onCompleted(route_source);
                          }
                        }
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

  bool routeIsComplete(Map<String, Place> route) {
    List<String> keys = route.keys.toList();
    if (keys.contains('source') && keys.contains('target')) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:nominatim/location/Location_Autocomplete.dart';
import 'package:nominatim/models/place_model.dart';
import 'package:nominatim/widgets/days_picker.dart';
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

  double topFirst = 20;
  double topSecond = 100;
  double size = 200;
  final sourceController = TextEditingController();
  final targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          height: size,
          width: 350,
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 250),
          left: 60,
          top: topFirst,
          child: Row(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: targetController,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.grey[300] ?? Colors.grey),
                    ),
                    hintText: 'destí',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Destí',
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
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 250),
          left: 60,
          top: topSecond,
          child: SizedBox(
            width: 250,
            child: TextField(
              enableInteractiveSelection: false,
              onTap: () async {
                String result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DaysPicker(
                            text: sourceController.text,
                          )),
                );
                sourceController.text = result.toString();
              },
              controller: sourceController,
              decoration: InputDecoration(
                enabled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Colors.grey[300] ?? Colors.grey),
                ),
                hintText: 'Origen',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Origen',
                labelStyle:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
        Positioned(
            right: 10,
            top: 45,
            child: ElevatedButton(
              onPressed: () {
                double temp = topFirst;
                topFirst = topSecond;
                topSecond = temp;
                size *= 1.2;
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 17)),
              child: Icon(Icons.swap_vert_circle, size: 40),
            )),
        // Tooltip(
        //   message: 'Switch',
        //   child: ElevatedButton(
        //       onPressed: () {},
        //       clipBehavior: Clip.none,
        //       style: ElevatedButton.styleFrom(
        //         padding: EdgeInsets.zero,
        //         minimumSize: Size(0, 0),
        //         elevation: 0,
        //       ),
        //       child:
        //           Icon(Icons.swap_vert_circle, size: 40, color: Colors.blue)),
        // ),
      ]),
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

import 'package:flutter/material.dart';

class DaysPicker extends StatefulWidget {
  Function? onChange;
  DaysPicker({super.key, this.onChange});

  @override
  State<DaysPicker> createState() => _DaysPickerState();
}

class _DaysPickerState extends State<DaysPicker> {
  List<String> days = ['Dil', 'Dim', 'Dic', 'Dij', 'Div', 'Dis', 'Diu'];
  List<String> longDays = [
    'Diluns',
    'Dimarts',
    'Dimecres',
    'Dijous',
    'Divendres',
    'Dissabte',
    'Diumenge'
  ];
  List<String> selected = [];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8, top: 8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days
                  .map((item) => Tooltip(
                        message: longDays[days.indexOf(item)],
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(15),
                                minimumSize: Size(0, 0),
                                backgroundColor: selected.contains(item)
                                    ? Colors.blue
                                    : Colors.white,
                                foregroundColor: selected.contains(item)
                                    ? Colors.white
                                    : Colors.blue,
                                textStyle: const TextStyle(fontSize: 17)),
                            onPressed: () {
                              if (!selected.contains(item)) {
                                selected.add(item);
                              } else {
                                selected.remove(item);
                              }
                              if (widget.onChange != null) {
                                debugPrint('onchange is not null $item');
                                widget.onChange!(selected);
                              } else {
                                debugPrint('onchange is null');
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(item),
                            )),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DaysPicker extends StatefulWidget {
  Function? onChange;
  String? text;
  DaysPicker({super.key, this.onChange, this.text});

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
  void initState() {
    if (widget.text != '') {
      selected = widget.text!.split(',');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter origin'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, selected.join((',')));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.text ?? 'No text typed'}'),
            Container(
              width: 600,
              child: Card(
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
                                          backgroundColor:
                                              selected.contains(item)
                                                  ? Colors.blue
                                                  : Colors.white,
                                          foregroundColor:
                                              selected.contains(item)
                                                  ? Colors.white
                                                  : Colors.blue,
                                          textStyle:
                                              const TextStyle(fontSize: 17)),
                                      onPressed: () {
                                        if (!selected.contains(item)) {
                                          debugPrint('$selected');
                                          selected.add(item);
                                          debugPrint('$selected');
                                        } else {
                                          selected.remove(item);
                                        }
                                        if (widget.onChange != null) {
                                          debugPrint(
                                              'onchange is not null $item');
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

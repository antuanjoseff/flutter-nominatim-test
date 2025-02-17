import 'package:flutter/material.dart';
import 'package:nominatim/models/nominatim_model.dart';
import 'package:nominatim/models/place_model.dart';

class ListNames extends StatefulWidget {
  final List<Place> data;
  TextEditingController textController;
  bool visible;

  ListNames({
    Key? key,
    required this.data,
    required this.textController,
    required this.visible,
  }) : super(key: key);

  @override
  State<ListNames> createState() => _ListNamesState();
}

class _ListNamesState extends State<ListNames> {
  @override
  Widget build(BuildContext context) {
    return widget.visible
        ? SingleChildScrollView(
            child: SizedBox(
              height: widget.data.length * 75,
              child: ListView.separated(
                primary: true,
                itemCount: widget.data?.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  Place place = widget.data![index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        onTap: () {
                          widget.textController.text = place.name;
                          setState(() {
                            widget.visible = !widget.visible;
                          });
                        },
                        child: Text(place.name),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : Container();
  }
}

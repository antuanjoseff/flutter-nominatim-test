import 'package:flutter/material.dart';
import 'package:nominatim/models/nominatim_model.dart';
import 'package:nominatim/models/place_model.dart';

class ListNames extends StatefulWidget {
  final String search;
  TextEditingController textController;
  bool visible;

  ListNames({
    Key? key,
    required this.search,
    required this.textController,
    required this.visible,
  }) : super(key: key);

  @override
  State<ListNames> createState() => _ListNamesState();
}

class _ListNamesState extends State<ListNames> {
  NominatimModel nominatim = NominatimModel();
  late FocusScopeNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusScopeNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('inside future builder');
    return FutureBuilder(
      future: nominatim.fetchPlaces(widget.search),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //print('project snapshot data is: ${projectSnap.data}');
          return SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          );
        }
        return widget.visible
            ? SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: FocusScope(
                    node: _focusNode,
                    child: ListView.separated(
                      primary: true,
                      itemCount: snapshot.data?.length ?? 0,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        Place place = snapshot.data![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // widget.textController.text = place.displayName;
                                // setState(() {
                                //   widget.visible = !widget.visible;
                                // });
                              },
                              child: Text(place.displayName),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nominatim/models/nominatim_model.dart';
import 'package:nominatim/models/place_model.dart';

class ListNames extends StatefulWidget {
  final String search;

  const ListNames({Key? key, required this.search}) : super(key: key);

  @override
  State<ListNames> createState() => _ListNamesState();
}

class _ListNamesState extends State<ListNames> {
  NominatimModel nominatim = NominatimModel();
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
        return SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              Place place = snapshot.data![index];
              return Column(
                children: <Widget>[Text(place.displayName)],
              );
            },
          ),
        );
      },
    );
  }
}

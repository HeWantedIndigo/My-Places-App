import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/place_details_card.dart';
import '../widgets/map_card.dart';
import '../providers/my_places.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {

  static const routeName = '/place_details_screen';

  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context).settings.arguments;
    final currentPlace = Provider.of<MyPlaces>(context, listen: false).findPlaceById(id);
    final mapUrl = LocationHelper.generateLocationPreviewImage(
      currentPlace.location.latitude,
      currentPlace.location.longitude,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPlace.title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PlaceDetailsCard(currentPlace),
            MapCard(
              mapUrl, 
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapsScreen(
                      initialLocation: currentPlace.location,
                      isSelecting: false,
                    )
                  )
                );
              }
            ),
          ]
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final myLocation = await Location().getLocation();
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(myLocation.latitude, myLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.onSelectPlace(myLocation.latitude, myLocation.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapsScreen(
          isSelecting: true,    
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(selectedLocation.latitude, selectedLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).primaryColor)
          ),
          alignment: Alignment.center,
          width: double.infinity,
          height: 140,
          child: _previewImageUrl == null ?
            Text(
              "No Location choosen!",
              style: Theme.of(context).textTheme.body1,
            ) :
            Image.network(
              _previewImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OutlineButton.icon(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                icon: Icon(Icons.my_location, color: Theme.of(context).primaryColor),
                label: Text("Current Location"),
                textColor: Theme.of(context).primaryColor,
                onPressed: _getCurrentUserLocation,
              ),
              OutlineButton.icon(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                icon: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                label: Text("Select on Map"),
                textColor: Theme.of(context).primaryColor,
                onPressed: _selectOnMap,
              ),
            ],
          ),
        )
      ],
    );
  }
}
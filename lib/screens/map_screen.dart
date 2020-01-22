import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapsScreen extends StatefulWidget {

  final Location initialLocation;
  final bool isSelecting;

  MapsScreen({
    this.initialLocation = const Location(latitude: 20.2961, longitude: 85.8245),
    this.isSelecting = true });

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {

  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Map",
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Theme.of(context).accentColor,
            onPressed: _pickedLocation == null ? null :
            () {
              Navigator.of(context).pop(_pickedLocation);
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting) ? null : {
          Marker(
            markerId: MarkerId('m1'),
            position: _pickedLocation == null ?
              LatLng(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude,
              ) : _pickedLocation
          ),
        },
      ),
    );
  }
}
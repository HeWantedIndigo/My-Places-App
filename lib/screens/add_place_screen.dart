import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/my_places.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName = '/add_place_screen';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();

}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  File _pickedImage;
  Location _myLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _myLocation == null) {
      return;
    }
    Provider.of<MyPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage, _myLocation);
    Navigator.pop(context);
  }

  void _selectPlace(double lat, double lng) {
    _myLocation = Location(
      latitude: lat,
      longitude: lng,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a Place",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "Name of the place",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                controller: _titleController,
              ),
              SizedBox(height: 15),
              ImageInput(_selectImage),
              SizedBox(height: 15),
              LocationInput(_selectPlace),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.save,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: _savePlace,
      ),
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:my_places/helpers/database_helper.dart';
import '../helpers/location_helper.dart';
import 'package:my_places/models/place.dart';
import 'dart:io';

class MyPlaces with ChangeNotifier {

  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(String title, File image, Location loc) async {
    final address = await LocationHelper.getPlaceAddress(loc.latitude, loc.longitude);
    final updatedLocation = Location(
      latitude: loc.latitude,
      longitude: loc.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );
    _places.add(newPlace);
    notifyListeners();
    DatabaseHelper.insert(
      'user_places', {
        'id' : newPlace.id, 
        'title' : newPlace.title, 
        'image' : newPlace.image.path,
        'loc_lat' : newPlace.location.latitude,
        'loc_lng' : newPlace.location.longitude,
        'address' : newPlace.location.address,
      }
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DatabaseHelper.getData('user_places');
    _places = dataList.map(
      (item) => Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        location: Location(
          latitude: item['loc_lat'],
          longitude: item['loc_lng'],
          address: item['address'],
        ),
      )
    ).toList();
    notifyListeners();
  }

  Place findPlaceById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/my_places.dart';
import './screens/add_place_screen.dart';
import './screens/place_details_screen.dart';
import './screens/places_visited_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: MyPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.amber,
              fontFamily: "Montserrat",
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            body1: TextStyle(
              color: Colors.purple,
              fontFamily: "KulimPark",
              fontSize: 24,
            ),
            body2: TextStyle(
              color: Colors.purple,
              fontFamily: "Montserrat",
              fontSize: 24,
            ),
          ),
        ),
        routes: {
          '/' : (ctx) => PlacesVisitedScreen(),
          AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName : (ctx) => PlaceDetailsScreen(),
        },
      ),
    );

  }

}
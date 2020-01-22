import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../screens/place_details_screen.dart';

class PlaceCard extends StatelessWidget {

  final Place currentPlace;

  PlaceCard(this.currentPlace);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName, arguments: currentPlace.id),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                child: Image.file(currentPlace.image),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(
                  currentPlace.title,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
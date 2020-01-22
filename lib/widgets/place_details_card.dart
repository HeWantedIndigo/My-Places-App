import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailsCard extends StatelessWidget {

  final Place currentPlace;

  PlaceDetailsCard(this.currentPlace);

  @override
  Widget build(BuildContext context) {
    return Card(
              margin: EdgeInsets.all(10),
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
                      currentPlace.location.address,
                      style: TextStyle(
                        fontFamily: "Kulim Park",
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
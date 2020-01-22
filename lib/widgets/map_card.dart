import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {

  final String mapUrl;
  final Function openMap;

  MapCard(this.mapUrl, this.openMap);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      ),
      elevation: 15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              child: Image.network(mapUrl),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "VIEW ON MAP",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onPressed: openMap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
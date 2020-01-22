import 'package:flutter/material.dart';
import 'package:my_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

import '../providers/my_places.dart';
import '../widgets/place_card.dart';

class PlacesVisitedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "My Places",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<MyPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator()) :
        Consumer<MyPlaces>(
          child: Center(
            child: Text(
            "No Places yet!",
            style: Theme.of(context).textTheme.title,
            ),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.places.length <=0 ?
          ch : GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 6.3/10.1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: greatPlaces.places.length,
            itemBuilder: (ctx, index) => PlaceCard(greatPlaces.places[index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        },
      ),
    );

  }

}
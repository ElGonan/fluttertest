import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/services/pokemon_service.dart';

// Just a second route to navigate to
class DetailRoute extends StatelessWidget {
  final String id;
  const DetailRoute({super.key, this.id = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Pokemon>(
          future: Pokemon.fromId(int.parse(id)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text('#$id: ${snapshot.data!.name.capitalize()}');
            } else {
              return Text('Pokemon not found');
            }
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Column(
            children: <Widget>[
              Text('ID: $id'),
              FutureBuilder<Pokemon>(
                future: Pokemon.fromId(int.parse(id)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CupertinoActivityIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text('Name: ${snapshot.data!.name.capitalize()}');
                  } else {
                    return Text('Pokemon not found');
                  }
                },
              ),
              Text('Hola'),
            ],
          ),
        ),
      )
    );
  }
}
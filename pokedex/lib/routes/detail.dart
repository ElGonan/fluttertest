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
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(500),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FutureBuilder<Pokemon>(
                  future: Pokemon.fromId(int.parse(id)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CupertinoActivityIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.network(snapshot.data!.spriteUrl, fit: BoxFit.cover,),
                          ),
                      CupertinoListTile(
                            title: Text('Type: ${snapshot.data!.type}'),),
                          CupertinoListTile(
                            title: Text('HP: ${snapshot.data!.stats["HP"]}'),),
                          CupertinoListTile(
                            title: Text('Attack: ${snapshot.data!.stats["Attack"]}'),),
                          CupertinoListTile(
                            title: Text('Defense: ${snapshot.data!.stats["Defense"]}'),),
                          CupertinoListTile(
                            title: Text('Special Attack: ${snapshot.data!.stats["Special Attack"]}'),),
                            CupertinoListTile(
                            title: Text('Special Defense: ${snapshot.data!.stats["Special Defense"]}'),),
                            CupertinoListTile(
                            title: Text('Speed: ${snapshot.data!.stats["Speed"]}'),),
                        ],
                      );
                    } else {
                      return Text('Pokemon not found');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
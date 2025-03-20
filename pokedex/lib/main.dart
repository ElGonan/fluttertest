import 'package:flutter/material.dart';
import 'services/pokemon_service.dart';
import 'package:flutter/cupertino.dart';
import 'routes/detail.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(primarySwatch: Colors.red),
      home: PokemonListScreen(),
    );
  }
}
class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}



class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonService _pokemonService = PokemonService();
  List<dynamic> _pokemonList = [];

  @override
  void initState() {
    super.initState();
    _loadPokemon();
  }

  void _loadPokemon() async {
    
    var list = await _pokemonService.fetchPokemons();
    setState(() {
      _pokemonList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex')),
      body: ListView.separated(
        itemCount: _pokemonList.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          var pokemon = _pokemonList[index];
          String name = pokemon['name'];
          String url = pokemon['url'];
          String img = PokemonPNG().getPokemonImageUrl(index + 1);
          
          String id = url.split('/')[url.split('/').length - 2];

          return ListTile(
            leading: Text(id, style: TextStyle(fontWeight: FontWeight.bold)), 
            title: Text(name.capitalize()), 
            trailing: SizedBox(
                width: 100,
                height: 150, 
                child: Row(
                  children: <Widget>[
                      Image.network(img),
                      Padding(padding: EdgeInsets.all(10)),
                    Icon(CupertinoIcons.forward),
                  ],
                )
            ),
              
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => DetailRoute(id: id)),
              );
            },
          );
        },
      ),
    );
    
  }
}


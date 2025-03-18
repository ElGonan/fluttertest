import 'package:flutter/material.dart';
import 'services/pokemon_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          
          // Extraer el ID desde la URL
          String id = url.split('/')[url.split('/').length - 2];

          return ListTile(
            leading: Text(id, style: TextStyle(fontWeight: FontWeight.bold)), // Mostrar el número
            title: Text(name.toUpperCase()), // Convertir el nombre en mayúsculas
            trailing: SizedBox(
                width: 100, // Ajusta el ancho según lo necesites
                height: 150, // Ajusta la altura según lo necesites
                child: Image.network(img),
              ),
              
            onTap: () {
              // Aquí puedes navegar a la pantalla de detalles
            },
          );
        },
      ),
    );
  }
}
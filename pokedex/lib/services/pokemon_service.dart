import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=151';

  Future<List<dynamic>> fetchPokemons() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['results'];
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}

class PokemonPNG {
  final String baseUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/';
  
  String getPokemonImageUrl(int id) {
    return '$baseUrl$id.png';
  }

}

class Pokemon {
  String name;
  int id;
  String spriteUrl;

  // Constructor privado para que no se pueda instanciar directamente
  Pokemon._(this.name, this.id, this.spriteUrl);

  // Método estático para crear un Pokémon desde la API
  static Future<Pokemon> fromId(int id) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pokemon._(
        data['name'], 
        data['id'], 
        data['sprites']['front_default'] ?? "",
      );
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}

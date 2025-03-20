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
  String type;
  Map<String, int> stats = {"HP": 0, "Attack": 0, "Defense": 0, "Special Attack": 0, "Special Defense": 0, "Speed": 0};

  // Constructor privado para que no se pueda instanciar directamente
  Pokemon._(this.name, this.id, this.spriteUrl, this.type, this.stats);

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
        data['types'][0]['type']['name'],
        {
          "HP": data['stats'][0]['base_stat'],
          "Attack": data['stats'][1]['base_stat'],
          "Defense": data['stats'][2]['base_stat'],
          "Special Attack": data['stats'][3]['base_stat'],
          "Special Defense": data['stats'][4]['base_stat'],
          "Speed": data['stats'][5]['base_stat'],
        }
      );
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}

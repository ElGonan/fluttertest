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
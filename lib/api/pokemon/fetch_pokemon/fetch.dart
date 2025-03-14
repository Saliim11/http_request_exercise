import 'dart:convert';

import 'package:http_request_exercise/api/pokemon/model/pokemon.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon_detail.dart';
import 'package:http_request_exercise/api/repo.dart';

Future<Pokemon> fetchPokemon() async {
  final response = await requestPokemon();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pokemon');
  }
}
Future<PokemonDetail> fetchDetailPokemon(String nama) async {
  final response = await requestDetailPokemon(nama);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PokemonDetail.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pokemon detail');
  }
}


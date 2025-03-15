import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_request_exercise/api/pokemon/fetch_pokemon/fetch.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon_detail.dart';

class DataProvider with ChangeNotifier {
  List<Result> _pokemons = [];
  bool _isLoading = false;

  List<Result> get pokemons => _pokemons;
  bool get isLoading => _isLoading;

  getListPoke() async {
    _isLoading = true;
    notifyListeners();
    try {
        Pokemon _dataPokemon = await fetchPokemon();
        // print("isi data pokemon ${_dataPokemon.results}");
        _pokemons = _dataPokemon.results ?? [];
        
    } catch (e) {
      throw Exception("Failed to load data: $e");

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  

  Future<PokemonDetail?> fetchPokemonDetail(String name) async {
    final url = 'https://pokeapi.co/api/v2/pokemon/$name';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return pokemonDetailFromJson(response.body);
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
  
}
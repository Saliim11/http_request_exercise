import 'package:flutter/material.dart';
import 'package:http_request_exercise/api/pokemon/fetch_pokemon/fetch.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon.dart';

class DataProvider with ChangeNotifier {
  late FewPokemon _dataPokemon;
  List<Result> _listPokemon = [];
  bool _isLoading = false;

  FewPokemon get pokemon => _dataPokemon;
  List<Result> get listPokemon => _listPokemon;
  bool get isLoading => _isLoading;

  getListPoke() async {
    _isLoading = true;
    notifyListeners();
    try {
        _dataPokemon = await fetchPokemon();
        print("isi data pokemon ${_dataPokemon.results}");
        _listPokemon = _dataPokemon.results ?? [];
        
    } catch (e) {
      throw Exception("Failed to load data: $e");

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
}
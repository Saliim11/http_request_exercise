import 'dart:convert';

PokemonDetail pokemonDetailFromJson(String str) =>
    PokemonDetail.fromJson(json.decode(str));

class PokemonDetail {
  final String name;
  final int height;
  final int weight;
  final List<Ability> abilities;
  final List<Type> types;
  final Stats stats;

  PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        stats: Stats.fromJson(json),
      );
}

class Ability {
  final String name;

  Ability({required this.name});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      Ability(name: json["ability"]["name"]);
}

class Type {
  final String name;

  Type({required this.name});

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(name: json["type"]["name"]);
}

class Stats {
  final int hp;
  final int attack;

  Stats({required this.hp, required this.attack});

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        hp: json["stats"][0]["base_stat"],
        attack: json["stats"][1]["base_stat"],
      );
}

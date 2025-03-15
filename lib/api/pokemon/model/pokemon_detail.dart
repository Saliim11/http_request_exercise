import 'dart:convert';

PokemonDetail pokemonDetailFromJson(String str) => PokemonDetail.fromJson(json.decode(str));

class PokemonDetail {
  final String name;
  final int height;
  final int weight;
  final List<Ability> abilities;
  final List<Type> types;
  final Stats stats;
  final String imageUrl;

  PokemonDetail({
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.stats,
    required this.imageUrl,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        stats: Stats.fromJson(json["stats"]),
        imageUrl: json["sprites"]["front_default"],
      );
}

class Ability {
  final String name;

  Ability({required this.name});

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        name: json["ability"]["name"],
      );
}

class Type {
  final String name;

  Type({required this.name});

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["type"]["name"],
      );
}

class Stats {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  Stats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory Stats.fromJson(List<dynamic> json) => Stats(
        hp: json[0]["base_stat"],
        attack: json[1]["base_stat"],
        defense: json[2]["base_stat"],
        specialAttack: json[3]["base_stat"],
        specialDefense: json[4]["base_stat"],
        speed: json[5]["base_stat"],
      );
}

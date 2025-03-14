// To parse this JSON data, do
//
//     final fewPokemon = fewPokemonFromJson(jsonString);

import 'dart:convert';

FewPokemon fewPokemonFromJson(String str) => FewPokemon.fromJson(json.decode(str));

String fewPokemonToJson(FewPokemon data) => json.encode(data.toJson());

class FewPokemon {
    final int? count;
    final String? next;
    final dynamic previous;
    final List<Result>? results;

    FewPokemon({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    factory FewPokemon.fromJson(Map<String, dynamic> json) => FewPokemon(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    final String? name;
    final String? url;

    Result({
        this.name,
        this.url,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

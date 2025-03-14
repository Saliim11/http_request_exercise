import 'package:flutter/material.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon_detail.dart';
import 'package:http_request_exercise/service/data_provider.dart';
import 'package:http_request_exercise/utils/type_color.dart';
import 'package:provider/provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.nama, required this.index});

  final String nama;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PokemonDetail?>(
        future: Provider.of<DataProvider>(context).fetchPokemonDetail(nama),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            final mainColor = getTypeColor(pokemon.types.first.name);

            return Stack(
              children: [
                // Background berdasarkan tipe
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: mainColor,
                ),
                // Konten
                SafeArea(
                  child: Column(
                    children: [
                      _buildHeroImage(pokemon, index),
                      _buildPokemonInfo(context, pokemon),
                    ],
                  ),
                ),
                // Tombol Kembali
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Data tidak tersedia'));
        },
      ),
    );
  }

  // Menampilkan gambar Pokémon dengan animasi Hero
  Widget _buildHeroImage(PokemonDetail pokemon, int index) {
    return Hero(
      tag: pokemon.name,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index}.png',
            ),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // Menampilkan informasi detail Pokémon
  Widget _buildPokemonInfo(BuildContext context, PokemonDetail pokemon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                pokemon.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pokemon.types.map((type) {
                  final color = getTypeColor(type.name);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Chip(
                      backgroundColor: color,
                      label: Text(
                        type.name.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Informasi Height & Weight
              _buildStatRow('Height', '${pokemon.height / 10} m'),
              _buildStatRow('Weight', '${pokemon.weight / 10} kg'),

              const SizedBox(height: 16),

              // Daftar Abilities
              _buildAbilitySection(pokemon.abilities),

              const SizedBox(height: 16),

              // Stat
              _buildStatRow('HP', '${pokemon.stats.hp}'),
              _buildStatRow('Attack', '${pokemon.stats.attack}'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk baris data
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan daftar abilities
  Widget _buildAbilitySection(List<Ability> abilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Abilities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: abilities.map((ability) {
            return Chip(
              label: Text(
                ability.name.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blueAccent,
            );
          }).toList(),
        ),
      ],
    );
  }
}

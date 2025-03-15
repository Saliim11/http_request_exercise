import 'package:flutter/material.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon_detail.dart';
import 'package:http_request_exercise/service/data_provider.dart';
import 'package:http_request_exercise/utils/type_color.dart';
import 'package:provider/provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.nama});

  final String nama;

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
                      _buildHeroImage(pokemon),
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
  Widget _buildHeroImage(PokemonDetail pokemon) {
    return Hero(
      tag: pokemon.name,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              pokemon.imageUrl,
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
              _buildStatHWRow('Height', '${pokemon.height / 10} m'),
              _buildStatHWRow('Weight', '${pokemon.weight / 10} kg'),

              const SizedBox(height: 16),

              // Daftar Abilities
              _buildAbilitySection(pokemon.abilities),

              const SizedBox(height: 16),

              // Stat
              _buildStatRow('HP', pokemon.stats.hp, 255),
              _buildStatRow('Attack', pokemon.stats.attack, 180),
              _buildStatRow('Defense', pokemon.stats.defense, 230),
              _buildStatRow('Special Attack', pokemon.stats.specialAttack, 180),
              _buildStatRow('Special Defense', pokemon.stats.specialDefense, 230),
              _buildStatRow('Speed', pokemon.stats.speed, 200),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk baris data
  Widget _buildStatHWRow(String label, String value) {
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

  Widget _buildStatRow(String label, int value, int maksStat) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
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
            value.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      LinearProgressIndicator(
        value: value / maksStat,
        color: _getStatColor(label),
        backgroundColor: Colors.grey.shade300,
        minHeight: 8, // Ketebalan progress bar
        borderRadius: BorderRadius.circular(10),
      ),
      const SizedBox(height: 8),
    ],
  );
}

Color _getStatColor(String stat) {
  switch (stat) {
    case 'HP':
      return Colors.red;
    case 'Attack':
      return Colors.orange;
    case 'Defense':
      return Colors.blue;
    case 'Special Attack':
      return Colors.purple;
    case 'Special Defense':
      return Colors.green;
    case 'Speed':
      return Colors.yellow;
    default:
      return Colors.grey;
  }
}

  // Widget untuk menampilkan daftar abilities
  Widget _buildAbilitySection(List<Ability> abilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: const Text(
            'Abilities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Wrap(
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
        ),
      ],
    );
  }
}

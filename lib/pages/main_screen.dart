import 'package:flutter/material.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon.dart';
import 'package:http_request_exercise/pages/detail_screen.dart';
import 'package:http_request_exercise/service/data_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => 
      Provider.of<DataProvider>(context, listen: false).getListPoke()
    );
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/pokemon.png",
          height: 50,
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.red, width: 3), // Warna khas Pokémon
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.5), // Efek cahaya Pokémon
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Pokemon...",
                        prefixIcon: Image.asset("assets/lock.png", height: 20, width: 20,),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        
                      ),
                      onSubmitted: (value) {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PokemonDetailScreen(nama: value),
                        ),
                      );
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: provider.pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = provider.pokemons[index];
                        return _buildPokemonCard(context, pokemon, index+1);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildPokemonCard(BuildContext context, Result pokemon, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PokemonDetailScreen(nama: pokemon.name!),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar Pokémon
            Hero(
              tag: pokemon.name!,
              child: Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index}.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // Nama Pokémon
            Text(
              pokemon.name!.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
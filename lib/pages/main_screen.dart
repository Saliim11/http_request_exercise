import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:http_request_exercise/api/pokemon/model/pokemon.dart';
import 'package:http_request_exercise/service/data_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamController<int> controller = StreamController<int>();

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
    final dataProvider = Provider.of<DataProvider>(context);
    List<Result> list = dataProvider.listPokemon;
    return Scaffold(
      body: Column(
        children: [
          FortuneWheel(
            items: [
              
            ],
          )
        ],
      ),
    );
  }
}
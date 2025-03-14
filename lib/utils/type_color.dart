import 'package:flutter/material.dart';

Map<String, Color> typeColors = {
  'normal': Colors.grey,
  'fire': Colors.red,
  'water': Colors.blue,
  'grass': Colors.green,
  'electric': Colors.yellow.shade700,
  'ice': Colors.cyan,
  'fighting': Colors.brown,
  'poison': Colors.purple,
  'ground': Colors.orange,
  'flying': Colors.indigo,
  'psychic': Colors.pink,
  'bug': Colors.lightGreen,
  'rock': Colors.brown.shade700,
  'ghost': Colors.deepPurple,
  'dragon': Colors.deepOrange,
  'dark': Colors.black,
  'steel': Colors.blueGrey,
  'fairy': Colors.pinkAccent,
};

Color getTypeColor(String type) {
  return typeColors[type.toLowerCase()] ?? Colors.grey;
}
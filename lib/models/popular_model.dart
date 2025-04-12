import 'package:flutter/material.dart';

class PopularDietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String colorie;
  bool boxselected;
  PopularDietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.colorie,
    required this.boxselected,
  });

  static List<PopularDietModel> getPopDiets() {
    List<PopularDietModel> popDiets = [];
    popDiets.add(
      PopularDietModel(
        name: "Honey pancake",
        iconPath: 'assets/icons/pancake.svg',
        level: "easy",
        duration: "30mins",
        colorie: "101col",
        boxselected: true,
      ),
    );
    popDiets.add(
      PopularDietModel(
        name: "Salad",
        iconPath: 'assets/icons/salad.svg',
        level: "medium",
        duration: "30mins",
        colorie: "101col",
        boxselected: false,
      ),
    );
    return popDiets;
  }
}

import 'package:flutter/material.dart';

class DietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String colorie;
    Color boxColor;
  bool viewToselected;
  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.colorie,
    required this.viewToselected,
     required this.boxColor
  });

  static List<DietModel> getDiets() {
    List<DietModel> diets = [];
    diets.add(
      DietModel(
        name: "Honey pancake",
        iconPath: 'assets/icons/pancake.svg',
        level: "easy",
        duration: "30mins",
        colorie: "101col",
        viewToselected: true,
        boxColor: Colors.amberAccent
      ),
    );
    diets.add(
      DietModel(
        name: "Salad",
        iconPath: 'assets/icons/salad.svg',
        level: "medium",
        duration: "30mins",
        colorie: "101col",
        viewToselected: false,
        boxColor: Colors.blueGrey
      ),
    );
    return diets;
  }
}

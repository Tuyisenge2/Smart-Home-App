import 'package:flutter/material.dart';

class CategoryModel{
  String name;
  String iconPath;
  Color boxColor;
  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor
  });
  static List<CategoryModel> getCategories(){
    List<CategoryModel>category =[];
    category.add(
      CategoryModel(name: "Salad", iconPath: 'assets/icons/salad.svg', boxColor: Colors.grey)
    );
    category.add(
      CategoryModel(name: "Cake", iconPath: 'assets/icons/pancake.svg', boxColor: Colors.lightBlueAccent)
    );category.add(
      CategoryModel(name: "Pie", iconPath: 'assets/icons/pie.svg', boxColor: Colors.tealAccent)
    );category.add(
      CategoryModel(name: "Smoothies", iconPath: 'assets/icons/ice-cream.svg', boxColor: Colors.orangeAccent)
    );
    return category;
  }
   
}
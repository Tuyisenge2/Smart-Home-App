import 'package:flutter/material.dart';

class SceneProvider extends ChangeNotifier {
  List<dynamic> _sceneData = [];
  bool isLoading = true;

  dynamic get sceneData => _sceneData;
  
  void setSceneData(dynamic sceneData) {
    _sceneData = sceneData ?? [];
    isLoading = false;
    notifyListeners();
  }
}

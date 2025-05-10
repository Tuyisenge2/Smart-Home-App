
import 'package:flutter/material.dart';

class SceneProvider extends ChangeNotifier {
  dynamic _sceneData;
  dynamic get sceneData => _sceneData;
  void setSceneData(dynamic sceneData){
    _sceneData=sceneData;
    notifyListeners();
  }
}
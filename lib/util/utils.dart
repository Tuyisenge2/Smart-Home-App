import 'package:flutter/material.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/provider/scene_provider.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Future<void> getSceneData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      if (token != null) {
        SceneListResponse response = await fetchScenes(token);
        context.read<SceneProvider>().setSceneData(response.scenes);
      }
    } catch (e) {
      print('Error fetching scene data:  $e');
      throw Exception('Error fetching scene data');
    }
  }
}

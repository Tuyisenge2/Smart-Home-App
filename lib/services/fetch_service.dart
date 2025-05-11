import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_app/models/fetch_scene_response.dart';

Future<SceneListResponse> fetchScenes(String token) async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/scenes'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    print(
      'oindoindddddddddddddddddddddddddddddddddddddddddddddddddddtttttttttttttttttttttttttttttt $token',
    );
    // print('Status Code: ${response.statusCode}');
    // print('Headers: ${response.headers}');
    // print('Body: ${response.body}');

    if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);
      //    print('Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData['scenes']}');
      return SceneListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load devices');
    }
  } catch (e) {
    print('Error fetching devices: $e');
    throw Exception('Failed to load devices: $e');
  }
}

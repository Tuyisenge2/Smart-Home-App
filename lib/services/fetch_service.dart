import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/services/api_service.dart';

Future<SceneListResponse> fetchScenes(String token) async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/scenes'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    // print('Status Code: ${response.statusCode}');
    // print('Headers: ${response.headers}');
    // print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SceneListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load scenes ');
    }
  } catch (e) {
    print('Error fetching scenes : $e');
    throw Exception('Failed to load scenes : $e');
  }
}

Future<DeviceListResponse> fetchDevice(String token) async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/devices'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    // print(
    //   'oindoindddddddddddddddddddddddddddddddddddddddddddddddddddtttttttttttttttttttttttttttttt $token',
    // );
    // print('Status Code: ${response.statusCode}');
    // print('Headers: ${response.headers}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);
      print(
        'Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData}',
      );
      return DeviceListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load devices');
    }
  } catch (e) {
    print('Error fetching devices: $e');
    throw Exception('Failed to load devices: $e');
  }
}



// Future<DeviceListResponse> fetchDevice(String token) async {
//   final apiService = ApiService(
//   baseUrl: 'http://10.0.2.2:8000/api',
//   token: token,
// );

//   return apiService.get(
//     endpoint: 'devices',
//     fromJson: DeviceListResponse.fromJson,
//   );
// }





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
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Accept': 'application/json',
      },
    );

    // print(
    //   'Status Codeddddddddddddddddddddddddddddddddddddddddddddddd: ${response.statusCode}',
    // );
    // print('Headers: ${response.headers}');
    // print('Bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SceneListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load scenes ');
    }
  } catch (e) {
    // print(
    //   'Error fetching scenesssssssssssssssssssssssssssssssssssssssssssssssss : $e',
    // );
    throw Exception('Failed to load scenes : $e');
  }
}

Future<DeviceListResponse> fetchDevice(String token) async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/devices'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    print(
      'oindoindddddddddddddddddddddddddddddddddddddddddddddddddddtttttttttttttttttttttttttttttt $token',
    );
    print('Status Codeeeeeeeeeeeeeeeeeeeeee: ${response.statusCode}');
    print('Headersdddddddddddddddddddddddddddd: ${response.headers}');
    print('Bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');

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
    //   print('Error fetching devices: $e');
    throw Exception('Failed to load devices: $e');
  }
}

Future<dynamic> updateDevice(String token, bool isActive, int id) async {
  try {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/devices/$id'),
      headers: {
        'content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{'is_active': isActive}),
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
      return "Device updated successfully";
    } else {
      throw Exception('Failed to update devices');
    }
  } catch (e) {
    throw Exception('Failed to update devices: $e');
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





// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as apiService;
import 'package:new_app/services/api_service.dart';

Future<dynamic> signupUser(
  String email,
  String password,
  String Confirm_Password,
  String name,
) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/auth/register'),
      headers: <String, String>{
        'content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'c_password': Confirm_Password,
      }),
    );

    if (response.statusCode == 201) {
      return {'message': 'user created successfully', 'status': true};
    } else if (response.statusCode == 200) {
      return {'message': 'user created successfully', 'status': true};
    }
  } catch (e) {
    print('Error signing up: $e');
    throw Exception('Failed to load user registration response: $e');
  }
}

Future<dynamic> createDevice(
  String name,
  int room_id,
  String images_url,
  String token,
) async {
  try {
    if (name.isEmpty) {
      throw Exception('Name and room_id are required');
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/devices'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'room_id': room_id,
        'images': images_url,
      }),
    );

    if (response.statusCode == 201) {
      return {'message': 'device created successfully', 'status': true};
    } else if (response.statusCode == 200) {
      return {'message': 'device created successfully', 'status': true};
    }
  } catch (e) {
    print('Error Creating device: $e');
    throw Exception('Failed to load device creation response: $e');
  }
}


// Future<dynamic> createScene(dynamic request,String token) async {
//   final apiService = ApiService(
//   baseUrl: 'http://10.0.2.2:8000/api/devices',
//   token: token,
// );

//   return apiService.post(
//     endpoint: 'scenes',
//     fromJson: dynamic.fromJson,
//     body: request.toJson(),
//   );
// }
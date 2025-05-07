// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final api = dotenv.env['EMU_API_URL'];

Future<dynamic> signupUser(
  String email,
  String password,
  String Confirm_Password,
  String name,
  String fcm_token,
) async {
  try {
    final response = await http.post(
      Uri.parse('$api/auth/register'),
      headers: <String, String>{
        'content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'c_password': Confirm_Password,
        'fcm_token': fcm_token,
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
      Uri.parse('$api/devices'),
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

Future<dynamic> createScene(
  String name,
  List daysOfWeek,
  String startTime,
  String endTime,
  bool sendNofication,
  String token,
  List devices,
) async {
  try {
    if (name.isEmpty) {
      throw Exception('Name is required');
    }
    if (startTime.isEmpty) {
      throw Exception('Start time is required');
    }
    if (endTime.isEmpty) {
      throw Exception('End time is required');
    }

    final response = await http.post(
      Uri.parse('$api/scenes'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'days_of_week': daysOfWeek,
        'start_time': startTime,
        'end_time': endTime,
        'send_notification': sendNofication,
        'is_active': false,
        'devices': devices,
      }),
    );
    // print('Status Codeeeeeeeeeeeeeeeeeeeeee: ${response.statusCode}');
    // print('Headersdddddddddddddddddddddddddddd: ${response.headers}');
    // print('Bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');
    if (response.statusCode == 201) {
      return {'message': 'Scenes created successfully', 'status': true};
    } else if (response.statusCode == 200) {
      return {'message': 'Scenes created successfully', 'status': true};
    }
  } catch (e) {
    print('Error Creating Scenes: $e');
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





Future<dynamic> createRoom(
  String name,
  String image_path,
  String token,
) async {
  try {
    if (name.isEmpty) {
      throw Exception('Name are required');
    }

    final response = await http.post(
      Uri.parse('$api/rooms'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'image_path': image_path,
      }),
    );

    print('Status Codeeeeeeeeeeeeee: ${response.statusCode}');
    print('Headerdsssssssssssssssssssssssssssssss: ${response.headers}');
    print('Bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');

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

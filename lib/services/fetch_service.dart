import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/models/fetch_rooms_response.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/models/notification_response.dart';
//import 'package:new_app/services/api_service.dart';

final api = dotenv.env['EMU_API_URL'];

Future<SceneListResponse> fetchScenes(String token) async {
  try {
    final response = await http.get(
      Uri.parse('$api/scenes'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Accept': 'application/json',
      },
    );
    print('Status Codeeeeeeeeeeeeeeeeeeeeee: ${response.statusCode}');
    print('Headersdddddddddddddddddddddddddddd: ${response.headers}');
    print('Bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) ?? [];
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
      Uri.parse('$api/devices'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    print(
      'oindoindddddddddddddddddddddddddddddddddddddddddddddddddddtttttttttttttttttttttttttttttt $token',
    );
    // print('Status Codeeeeeeeeeeeeeeeeeeeeee: ${response.statusCode}');
    // print('Headersdddddddddddddddddddddddddddd: ${response.headers}');
    // print('Bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy: ${response.body}');

    if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);
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
      Uri.parse('$api/devices/$id'),
      headers: {
        'content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{'is_active': isActive}),
    );

    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return "Device updated successfully";
    } else {
      throw Exception('Failed to update devices');
    }
  } catch (e) {
    throw Exception('Failed to update devices: $e');
  }
}

Future<dynamic> updateScenes(String token, bool isActive, int id) async {
  try {
    final response = await http.put(
      Uri.parse('$api/scenes/$id'),
      headers: {
        'content-Type': 'application/json;charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{'is_active': isActive}),
    );

    // print('Status Code: ${response.statusCode}');
    // print('Headers: ${response.headers}');
    // print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print(
      //   'Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData}',
      // );
      return "Device updated successfully";
    } else {
      throw Exception('Failed to update devices');
    }
  } catch (e) {
    throw Exception('Failed to update devices: $e');
  }
}

Future<RoomListResponse> fetchRooms(String token) async {
  try {
    final response = await http.get(
      Uri.parse('$api/rooms'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);
      // print(
      //   'Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData}',
      // );
      return RoomListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load devices');
    }
  } catch (e) {
    //   print('Error fetching devices: $e');
    throw Exception('Failed to load roomssssssssssssssssssssssssss: $e');
  }
}

Future<NotiListResponse> fetchNotification(String token) async {
  try {
    final response = await http.get(
      Uri.parse('$api/notifications'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);

      return NotiListResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load devices');
    }
  } catch (e) {
    //   print('Error fetching devices: $e');
    throw Exception('Failed to load roomssssssssssssssssssssssssss: $e');
  }
}

Future<DeviceListResponse> searchDevices(String query,String token) async {
      try {
// final response = await http.get(
//       Uri.parse('$api/scenes'),
//       headers: {
//         HttpHeaders.authorizationHeader: "Bearer $token",
//         'Accept': 'application/json',
//       },
//     );
                  print('dfRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRrrrrr $token');
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/devices/search?name=$query'), // Update your API URL
        headers: {
                  HttpHeaders.authorizationHeader: "Bearer $token",
          'Accept': 'application/json'},
      );
      print('sssssssssssDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDdddd $response');
print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print(': ${response.body}');
       if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);
      // print(
      //   'Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData}',
      // );
      return DeviceListResponse.fromJson(jsonData);
    } else {
            throw Exception('Failed to load devices');

    }         
           } catch (e) {
      print('ErrorCCCCCCCCCCCCCCVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV: $e');
            throw Exception('Failed to load devices');

     
    } 
   
  }
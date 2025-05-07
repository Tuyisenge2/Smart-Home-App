import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_app/models/room_model.dart';

class RoomService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/rooms';

  // Create a room
  static Future<RoomModel?> createRoomModel(String name, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'description': description}),
    );

    if (response.statusCode == 201) {
      return RoomModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Get all rooms
  static Future<List<RoomModel>> getRooms() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> roomsJson = jsonDecode(response.body);
      return roomsJson.map((json) => RoomModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }
}

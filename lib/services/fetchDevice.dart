import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_app/models/devices_model.dart';

Future<DevicesModel> fetchDevices() async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/devices/2'),
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE3NDY3MDIxMzAsImV4cCI6MTc0NjcwNTczMCwibmJmIjoxNzQ2NzAyMTMwLCJqdGkiOiJwWmh2Nk9mdG5CdWRYSU01Iiwic3ViIjoiMyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Ra29tfICPfw2vkAaPRAZZ8dcxs3VMS_2EeApZlJA9jU",
      },
    );
    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      // ignore: avoid_print
      final jsonData = jsonDecode(response.body);
      print('Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData['data']}');
      return DevicesModel.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load devices');
    }
  } catch (e) {
    print('Error fetching devices: $e');
    throw Exception('Failed to load devices: $e');
  }
}

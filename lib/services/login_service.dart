import 'dart:convert';

import 'package:http/http.dart';
import 'package:new_app/models/user_login_response.dart';
import 'package:http/http.dart' as http;

Future<UserLoginResponse> loginUser(String email, String Password) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/auth/login'),
      headers: <String, String>{
        'content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': Password,
      }),
    );
    if (response.statusCode == 201) {
    
      return UserLoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('22222222222222222222222222222222222222222222: ${response.body}');

         final jsonData = jsonDecode(response.body);
      return UserLoginResponse.fromJson(
        jsonData['data'] as Map<String, dynamic>,
      );
    } 
    else {
      print('3333333333333333333333333333333333333333333333: ${response.body}');
      throw Exception('Failed to load user login response');
    }
  } catch (e) {
    print('Error logging in: $e');
    throw Exception('Failed to load user login response: $e');
  }
}





// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:new_app/models/devices_model.dart';

// Future<DevicesModel> fetchDevices() async {
//   try {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8000/api/devices/2'),
//       headers: {
//         HttpHeaders.authorizationHeader:
//             "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE3NDY3MDIxMzAsImV4cCI6MTc0NjcwNTczMCwibmJmIjoxNzQ2NzAyMTMwLCJqdGkiOiJwWmh2Nk9mdG5CdWRYSU01Iiwic3ViIjoiMyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Ra29tfICPfw2vkAaPRAZZ8dcxs3VMS_2EeApZlJA9jU",
//       },
//     );
//     print('Status Code: ${response.statusCode}');
//     print('Headers: ${response.headers}');
//     print('Body: ${response.body}');

//     if (response.statusCode == 200) {
//       // ignore: avoid_print
//       final jsonData = jsonDecode(response.body);
//       print('Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData['data']}');
//       return DevicesModel.fromJson(jsonData['data']);
//     } else {
//       throw Exception('Failed to load devices');
//     }
//   } catch (e) {
//     print('Error fetching devices: $e');
//     throw Exception('Failed to load devices: $e');
//   }
// }

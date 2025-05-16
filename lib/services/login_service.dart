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

         final jsonData = jsonDecode(response.body);
      return UserLoginResponse.fromJson(
        jsonData['data'] as Map<String, dynamic>,
      );
    } 
    else {
      throw Exception('Failed to load user login response from backend');
    }
  } catch (e) {
    print('Error logging in: $e');
    throw Exception('Failed to load user login response: $e');
  }
}



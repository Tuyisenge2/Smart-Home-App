// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> signupUser( String email, String password,String Confirm_Password,String name) async{
  try{
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/auth/register'),
      headers:<String,String>{
      'content-Type': 'application/json;charset=UTF-8',
    },
      body:jsonEncode(<String,String>{
      'name': name,
      'email': email,
      'password': password,
      'c_password': Confirm_Password,
    })
    );
     if (response.statusCode == 201) {
    return {'message': 'user created successfully','status':true};
    } else if (response.statusCode == 200) {

    return {'message': 'user created successfully','status':true};
    } 
  }catch(e){
    print('Error signing up: $e');
    throw Exception('Failed to load user registration response: $e');
  }
}

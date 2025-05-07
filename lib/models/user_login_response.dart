// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:ffi';

class UserLoginResponse {
  
  final String access_token;
  final String token_type;
  final int expires_in;
  final dynamic user;

  UserLoginResponse({
    required this.access_token,
    required this.token_type,
    required this.expires_in, 
    required this.user, 

  });

factory UserLoginResponse.fromJson(Map<String,dynamic>json){
return switch(json){
{'access_token':String access_token,'token_type':String token_type,'expires_in':int expires_in,'user':dynamic user}
=> UserLoginResponse(access_token: access_token,token_type: token_type,expires_in: expires_in,user: user) ,
_=> throw const FormatException('failed to load user login response'),
};
}}
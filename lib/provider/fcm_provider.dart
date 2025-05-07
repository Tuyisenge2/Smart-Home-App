 import 'package:flutter/material.dart';

class FcmProvider extends ChangeNotifier{

String fcmToken='';

String get getFcmToken => fcmToken;

void setFcmToken(String token){
fcmToken =token;
notifyListeners();
}
}


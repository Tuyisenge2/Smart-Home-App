import 'package:flutter/material.dart';

class NotProvider extends ChangeNotifier {

List <dynamic>notificationData=[];

dynamic get getNotification => notificationData;

void setNotificationData(List<dynamic> data){
notificationData=data;
notifyListeners();
}

}
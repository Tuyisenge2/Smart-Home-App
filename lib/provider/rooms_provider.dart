import 'package:flutter/material.dart';

class RoomsProvider extends ChangeNotifier {
  List<dynamic> _roomData = [];
  bool isLoading = true;
  dynamic get roomData => _roomData;
  void setRoomData(dynamic roomData) {
    _roomData = roomData;
    isLoading = false;
    notifyListeners();
  }
}

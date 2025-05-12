import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  List<dynamic> _deviceData = [];
  bool isLoading = true;
  dynamic get deviceData => _deviceData;
  void setDeviceData(dynamic deviceData) {
    _deviceData = deviceData ?? [];
    isLoading = false;
    notifyListeners();
  }
}

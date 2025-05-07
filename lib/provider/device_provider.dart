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

 Future<void> fetchDevices() async {
    try {
      isLoading = true;
      notifyListeners();
           
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }


}

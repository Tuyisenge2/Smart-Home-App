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
      
      // Call your API to get devices
      // final response = await yourApiService.getDevices();
      // _deviceData = response.data;
      
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }


}

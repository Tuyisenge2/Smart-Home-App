import 'package:flutter/material.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/provider/device_provider.dart';
import 'package:new_app/provider/scene_provider.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<FetchDeviceResponse> fetchDevices(String token) async {
//   try {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8000/api/devices/2'),
//       headers: {
//         HttpHeaders.authorizationHeader:
//             "Bearer $token",
//       },
//     );
//     print('Status Code: ${response.statusCode}');
//     print('Headers: ${response.headers}');
//     print(': ${response.body}');

//     if (response.statusCode == 200) {
//       // ignore: avoid_print
//       final jsonData = jsonDecode(response.body);
//       print('Dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: ${jsonData['data']}');
//       return FetchDeviceResponse.fromJson(jsonData['data']);
//     } else {
//       throw Exception('Failed to load devices');
//     }
//   } catch (e) {
//     print('Error fetching devices: $e');
//     throw Exception('Failed to load devices: $e');
//   }
// }

class deviceUtils {
  static Future<void> getDevicesData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      dynamic deviceData = context.read<DeviceProvider>().deviceData;
      if (token != null) {
        DeviceListResponse response = await fetchDevice(token);
        context.read<DeviceProvider>().setDeviceData(response.devices);
      }
    } catch (e) {
      print('Error fetching device data: Error is $e');
    }
  }

  static Future<void> getSceneData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      dynamic sceneData = context.read<SceneProvider>().sceneData;
      if (token != null) {
        SceneListResponse response = await fetchScenes(token);
        context.read<SceneProvider>().setSceneData(response.scenes);
      }
    } catch (e) {
      //  print('Error fetching scene data:  $e');
      throw Exception('Error fetching scene data:  ');
    }
  }
}

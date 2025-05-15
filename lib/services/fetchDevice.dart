// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:new_app/models/devices_model.dart';
// import 'package:new_app/models/fetch_device_response.dart';

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

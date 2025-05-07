import 'package:flutter/material.dart';
import 'package:new_app/components/device_card.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/provider/search_provider.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<FetchDeviceResponse> _results = [];
  bool _isLoading = false;

  Future<void> getSearchData(String query) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      if (token != null) {
        DeviceListResponse response = await searchDevices(query, token);
        setState(() {
          _results = response.devices;
        });
        context.read<SearchProvider>().setSearchData(response.devices);
      }
    } catch (e) {
      setState(() {
        _results = [];
      });
      print('Error fetching device data: $e');
    }
  }

  Widget _buildSearchResults(List<FetchDeviceResponse> searchData) {
    return ListView.builder(
      itemCount: (searchData.length / 2).ceil(),
      itemBuilder: (context, index) {
        final int firstIndex = index * 2;
        final int secondIndex = firstIndex + 1;

        final firstDevice = searchData[firstIndex];
        final secondDevice =
            secondIndex < searchData.length ? searchData[secondIndex] : null;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: DeviceCard(
                  name: firstDevice.Device_name,
                  imageUrl:
                      firstDevice.images_url.isNotEmpty
                          ? firstDevice.images_url
                          : 'assets/images/AirCond.png',
                  id: firstDevice.id,
                  isActive: firstDevice.is_active,
                  roomName: firstDevice.Device_room.toString(),
                ),
              ),
              SizedBox(width: 8),
              if (secondDevice != null)
                Expanded(
                  child: DeviceCard(
                    name: secondDevice.Device_name,
                    imageUrl:
                        secondDevice.images_url.isNotEmpty
                            ? secondDevice.images_url
                            : 'assets/images/AirCond.png',
                    id: secondDevice.id,
                    isActive: secondDevice.is_active,
                    roomName: secondDevice.Device_room.toString(),
                  ),
                )
              else
                Expanded(child: Container()), // Empty space for alignment
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              onChanged: (value) => getSearchData(value),
              decoration: InputDecoration(
                hintText: 'Search device name...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child:
                  _results.isEmpty
                      ? Center(
                        child: Text(
                          'No devices found',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : _buildSearchResults(_results),
            ),
          ],
        ),
      ),
    );
  }
}

//import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:new_app/components/device_card.dart';
// import 'package:new_app/models/fetch_device_response.dart';
// import 'package:new_app/provider/search_provider.dart';
// import 'package:new_app/services/fetch_service.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _results = [];
//   bool _isLoading = false;

//   Future<void> getSearchData(String query) async {
//     try {
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       String? token = pref.getString('token');
//       // dynamic deviceData = context.read<SearchProvider>().searchData;
//       if (token != null) {
//         DeviceListResponse response = await searchDevices(query, token);
//         setState(() {
//           _results = response.devices;
//         });
//         context.read<SearchProvider>().setSearchData(response.devices);
//         print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
//       }
//     } catch (e) {
//       setState(() {
//         _results = [];
//       });
//       print('Error fetching device data: Error is $e');
//     }
//   }

//   Widget _buildSearchResults(List searchData) {
//     return ListView.builder(
//       itemCount: searchData.length,
//       itemBuilder: (context, index) {
//         final device = searchData[index];
//         return Padding(
//           padding: EdgeInsets.only(right: 0, left: 0),
//           child:
// Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DeviceCard(
//                 name: device.Device_name,
//                 imageUrl:
//                     device.images_url != ''
//                         ? device.images_url
//                         : 'assets/images/AirCond.png',
//                 id: device.id,
//                 isActive: device.is_active,
//                 roomName: '',
//               ),
//               SizedBox(width: 8),
//               if (index + 1 < device.length)
//                 // DeviceCard(
//                 //   id: device[index + 1].id,
//                 //   name: device[index + 1].Device_name,
//                 //   imageUrl:
//                 //       device[index].images_url != ''
//                 //           ? device[index].images_url
//                 //           : 'assets/images/AirCond.png',
//                 //   isActive: device[index + 1].is_active,
//                 //   roomName: '',
//                 // ),
//                 SizedBox(width: 8),
//             ],
//           ),
//         );
//         // ListTile(
//         //   title: Text(
//         //     device.Device_name,
//         //     style: TextStyle(color: Colors.white),
//         //   ), // Changed from device.name to device.Device_name
//         //   subtitle: Text(
//         //     "Room: ${device.Device_room}",
//         //     style: TextStyle(color: Colors.white),
//         //   ), // Example of using another property
//         //   onTap: () {
//         //     // Optional: Add action when a device is tapped
//         //   },
//         // );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     dynamic searchData = context.watch<SearchProvider>().searchData;
//     print(
//       "hjjjjjjjjjjjjjjjgfdfdghh  ${_results} hhhhhhhhhhhhhhhhhhjjjjjjjjjjjjjjj",
//     );

//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               style: TextStyle(color: Colors.white),
//               onChanged: (value) async {
//                 setState(() {
//                   getSearchData(value);
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search device name...',
//                 hintStyle: TextStyle(color: Colors.grey[400]),
//                 border: OutlineInputBorder(),

//                 suffixIcon: Icon(Icons.search, color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(child: _buildSearchResults(_results)),
//           ],
//         ),
//       ),
//     );
//   }
// }

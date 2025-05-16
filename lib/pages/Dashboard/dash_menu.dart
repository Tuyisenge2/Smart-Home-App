// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:new_app/models/devices_model.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/services/fetchDevice.dart';

class DashMenu extends StatefulWidget {
  const DashMenu({super.key});
  @override
  _DashMenuState createState() => _DashMenuState();
}

class _DashMenuState extends State<DashMenu> {
  late Future<FetchDeviceResponse> _futureDevices;
  void initState() {
    super.initState();
     // _futureDevices = fetchDevices();
    print('futureDevices $_futureDevices');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Menu')),
      body: Center(
        //  child: FutureBuilder<DevicesModel>(
        //   future: _futureDevices,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       print('objecttttttttttttttttttttttttttt ${snapshot.data!.name}');
        //       return Column(
        //         children: [Text('snauhhhhhhhhhhhhhhh ${snapshot.data!.name}')],
        //       );
        //     } else if (snapshot.hasError) {
        //       print('9jubrurtbueooooooott $snapshot.error');

        //       return Text('$snapshot.error');
        //     }
        //     return const CircularProgressIndicator();
        //   },
        // ),
      ),
    );
  }
}






// // ignore_for_file: library_private_types_in_public_api


// Future<Album> fetchAlbum() async {
//   final repsonse = await http.get(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//     headers: {HttpHeaders.authorizationHeader: "Bearer token"},
//   );
//   if (repsonse.statusCode == 200) {
//     return Album.fromJson(jsonDecode(repsonse.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }



// class DashMenu extends StatefulWidget {
// const DashMenu({super.key});
// @override
//  _DashMenuState createState()=> _DashMenuState();
// }



// class _DashMenuState extends State<DashMenu>{
//   late Future<Album> futureAlbum;
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Fetch Data Example')),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   children: [
//                     Text('result of users  ${snapshot.data!.userId}'),
//                     Text(snapshot.data!.title),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('$snapshot.error');
//               }
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
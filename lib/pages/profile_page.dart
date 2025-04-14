import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/device_card.dart';

class ProfilePage extends StatelessWidget {
  final List<String> entries = <String>['a', 'b', 'c'];
  final List<int> colorCodes = <int>[600, 400, 500];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/livingRoom.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 65,
                            width: 274,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF31373C),
                                    borderRadius: BorderRadius.circular(70),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      fit: BoxFit.contain,
                                      'assets/icons/greaterThan.svg',
                                      height: 1,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Living Room",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF181D23),
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.7],
                                  tileMode: TileMode.mirror,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DeviceCard(), DeviceCard()],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DeviceCard(), DeviceCard()],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ProfilePage extends StatelessWidget {
//   final List<String> entries = <String>['a', 'b', 'c'];
//   final List<int> colorCodes = <int>[600, 400, 500];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: 1000,
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: <Widget>[
//               Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 color: Colors.black.withOpacity(0.8),
//               ),
//               SvgPicture.asset('assets/icons/RectangleCurve.svg'),
//               SizedBox(
//                 height: 250,
//                 width: double.infinity,
//                 child: SvgPicture.asset(' assets/icons/RectangleCurve.svg'),
//               ),
//               Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 alignment: Alignment(0, -0.7555555),
//                 child: Container(
//                   height: 180,
//                   width: 180,
//                   decoration: BoxDecoration(
//                     color: Colors.lightBlueAccent.withOpacity(1),
//                     borderRadius: BorderRadius.all(Radius.circular(100)),
//                   ),
//                   child: Icon(Icons.face_4, color: Colors.white, size: 120),
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 alignment: Alignment(0, 1),
//                 child: Container(
//                   width: 800,
//                   height: 710,
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Text(
//                           "Tuyisenge Tite",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           "tuyisengetito2@gmail.com",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w300,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 20),
//                       Container(
//                         height: 200,
//                         width: 360,
//                         padding: EdgeInsets.only(left: 10, top: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset('assets/icons/edit.svg'),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Edit profile information',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.notifications_active,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Notification',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(width: 160),
//                                 SizedBox(
//                                   height: 30,
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Text('ON'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 SvgPicture.asset('assets/icons/translate.svg'),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Language',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(width: 160, height: 1),
//                                 SizedBox(
//                                   height: 30,
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Text('ENGLISH'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 20),

//                       Container(
//                         height: 200,
//                         width: 360,
//                         padding: EdgeInsets.only(left: 10, top: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset('assets/icons/edit.svg'),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Edit profile information',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.notifications_active,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Notification',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(width: 160),
//                                 SizedBox(
//                                   height: 30,
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Text('ON'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 SvgPicture.asset('assets/icons/translate.svg'),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Language',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(width: 160, height: 1),
//                                 SizedBox(
//                                   height: 30,
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Text('ENGLISH'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 20),

//                       Container(
//                         height: 200,
//                         width: 360,
//                         padding: EdgeInsets.only(left: 10, top: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset('assets/icons/edit.svg'),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Edit profile information',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.notifications_active,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Notification',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(width: 160),
//                                 SizedBox(
//                                   height: 30,
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Text('ON'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 SvgPicture.asset('assets/icons/translate.svg'),
//                                 SizedBox(width: 10, height: 1),

//                                 Text(
//                                   'Language',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 SizedBox(width: 160, height: 1),
//                                 SizedBox(
//                                   height: 30,
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Text('ENGLISH'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(top: 17, left: 10, right: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () => {},
//                       icon: Icon(
//                         Icons.notifications_active,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () => {},
//                           icon: Icon(Icons.history, color: Colors.white),
//                         ),
//                         IconButton(
//                           onPressed: () => {},
//                           icon: Icon(Icons.more_vert, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

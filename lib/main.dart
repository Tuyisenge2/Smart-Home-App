import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/pages/Dashboard/Dashboard.dart';
//import 'package:new_app/pages/ResetPassword.dart' show Resetpassword;
import 'package:new_app/pages/device_manage/device_management.dart';
import 'package:new_app/pages/Dashboard/rooms_list.dart';
import 'package:new_app/pages/LoginPage.dart';
import 'package:new_app/pages/ResetPassword.dart' show Resetpassword;
import 'package:new_app/pages/forgetPassword.dart' show Forgetpassword;
import 'package:new_app/pages/hero_section.dart';
//import 'package:new_app/pages/home.dart';
import 'package:new_app/pages/login.dart' show Login;
import 'package:new_app/pages/profile_page.dart';
import 'package:new_app/pages/room_manage/room_details.dart';
import 'package:new_app/pages/room_manage/room_single_device.dart';
import 'package:new_app/pages/scene/create_scene.dart';
import 'package:new_app/pages/signup.dart' show Signup;
import 'package:new_app/pages/Dashboard/rooms_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HeroSection()),
      GoRoute(path: '/', builder: (context, state) => HeroSection()),
      GoRoute(path: '/Login', builder: (context, state) => Login()),
      GoRoute(path: '/signup', builder: (context, state) => Signup()),
      GoRoute(path: '/forget', builder: (context, state) => Forgetpassword()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => DashboardWithBottom(),
      ),
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      GoRoute(path: '/createScene', builder: (context, state) => CreateScene()),
      GoRoute(path: '/device', builder: (context, state) => deviceManagement()),
      GoRoute(path: '/roomDetail', builder: (context, state) => RoomDetails()),
      GoRoute(path: '/roomDeviceDetail', builder: (context, state) => RoomSingleDevice()),

      GoRoute(
        path: '/RoomList',
        builder: (context, state) => RoomList()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/components/searchpage.dart';
import 'package:new_app/pages/Dashboard/Dashboard.dart';
//import 'package:new_app/pages/ResetPassword.dart' show Resetpassword;
import 'package:new_app/pages/device_manage/device_management.dart';
import 'package:new_app/pages/forgetPassword.dart' show Forgetpassword;
import 'package:new_app/pages/hero_section.dart';
//import 'package:new_app/pages/home.dart';
import 'package:new_app/pages/login.dart' show Login;
import 'package:new_app/pages/notification_page.dart';
import 'package:new_app/pages/profile_page.dart';
import 'package:new_app/pages/room_manage/room_details.dart';
import 'package:new_app/pages/room_manage/room_single_device.dart';
import 'package:new_app/pages/scene/create_scene.dart';
import 'package:new_app/pages/signup.dart' show Signup;
import 'package:new_app/pages/splash_screen.dart';
import 'package:new_app/provider/device_provider.dart';
import 'package:new_app/provider/fcm_provider.dart';
import 'package:new_app/provider/is_user_auth_provider.dart';
import 'package:new_app/provider/not_provider.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/provider/scene_provider.dart';
import 'package:new_app/provider/search_provider.dart';
import 'package:new_app/provider/user_provider.dart';
import 'package:new_app/services/auth_service.dart';
import 'package:new_app/services/firebase_messagingService.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();

  final GoRouter _router = GoRouter(
    routes: [
      //  GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/', builder: (context, state) => HeroSection()),
      GoRoute(path: '/Login', builder: (context, state) => Login()),
      GoRoute(path: '/signup', builder: (context, state) => Signup()),
      GoRoute(path: '/forget', builder: (context, state) => Forgetpassword()),
      GoRoute(
        path: '/notification',
        builder: (context, state) => NotificationPage(),
      ),

      GoRoute(
        path: '/dashboard',
        builder: (context, state) => DashboardWithBottom(),
      ),
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      GoRoute(path: '/search', builder: (context, state) => SearchPage()),
      GoRoute(path: '/createScene', builder: (context, state) => CreateScene()),
      GoRoute(path: '/device', builder: (context, state) => deviceManagement()),
      GoRoute(
        path: '/roomDetail',
        builder: (context, state) {
          final roomData = state.extra as Map<String, dynamic>;
          return RoomDetails(
            id: roomData['id'] as int,
            name: roomData['name'] as String,
            count: roomData['deviceCount'] as int,
            devices: roomData['devices'] as List<dynamic>,
            image_path: roomData['image_path'] as String,
          );
        },
      ),
      GoRoute(
        path: '/roomDeviceDetail',
        builder: (context, state) {
          final devData = state.extra as Map<String, dynamic>;
          return RoomSingleDevice(
            deviceName: devData['deviceName'] as String,
            deviceImageUrl: devData['deviceImageUrl'] as String,
            isActive: devData['isActive'] as bool,
            id: devData['id'] as int,
            roomName: devData['roomName'] as String,
          );
        },
      ),
    ],
  );

  // Initialize Firebase Messaging Service
  final messagingService = FirebaseMessagingService();
  await messagingService.initialize();
  messagingService.setRouter(_router); //
  final String? token = await messagingService.getFcmToken();

  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = initialMessage.data['route'] ?? '/notification';
      _router.go(Uri.parse(route).path); // Parse as URI
    });
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        // ChangeNotifierProvider(create: (context) => IsUserAuthProvider()),
        ChangeNotifierProvider(create: (context) => SceneProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider()),
        ChangeNotifierProvider(create: (context) => FcmProvider()),
        ChangeNotifierProvider(create: (context) => RoomsProvider()),
        ChangeNotifierProvider(create: (context) => NotProvider()),
        ChangeNotifierProvider(
          create: (context) {
            final provider = FcmProvider();
            if (token != null) {
              provider.setFcmToken(token);
            }
            return provider;
          },
        ),
      ],
      child: MyApp(messagingService: messagingService, router: _router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseMessagingService messagingService;
  final GoRouter router;
  MyApp({super.key, required this.messagingService, required this.router});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

































// 
//
//


























//import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:go_router/go_router.dart';
// import 'package:new_app/pages/Dashboard/Dashboard.dart';
// //import 'package:new_app/pages/ResetPassword.dart' show Resetpassword;
// import 'package:new_app/pages/device_manage/device_management.dart';
// import 'package:new_app/pages/forgetPassword.dart' show Forgetpassword;
// import 'package:new_app/pages/hero_section.dart';
// //import 'package:new_app/pages/home.dart';
// import 'package:new_app/pages/login.dart' show Login;
// import 'package:new_app/pages/notification_page.dart';
// import 'package:new_app/pages/profile_page.dart';
// import 'package:new_app/pages/room_manage/room_details.dart';
// import 'package:new_app/pages/room_manage/room_single_device.dart';
// import 'package:new_app/pages/scene/create_scene.dart';
// import 'package:new_app/pages/signup.dart' show Signup;
// import 'package:new_app/pages/splash_screen.dart';
// import 'package:new_app/provider/device_provider.dart';
// import 'package:new_app/provider/fcm_provider.dart';
// import 'package:new_app/provider/is_user_auth_provider.dart';
// import 'package:new_app/provider/rooms_provider.dart';
// import 'package:new_app/provider/scene_provider.dart';
// import 'package:new_app/provider/user_provider.dart';
// import 'package:new_app/services/auth_service.dart';
// import 'package:new_app/services/firebase_messagingService.dart';
// import 'package:provider/provider.dart';

// Future<void> main() async {
//   await dotenv.load(fileName: "lib/.env");
//   WidgetsFlutterBinding.ensureInitialized();

//   final GoRouter _router = GoRouter(
//     routes: [
//       GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
//       GoRoute(path: '/hero', builder: (context, state) => HeroSection()),
//       GoRoute(path: '/Login', builder: (context, state) => Login()),
//       GoRoute(path: '/signup', builder: (context, state) => Signup()),
//       GoRoute(path: '/forget', builder: (context, state) => Forgetpassword()),
//       GoRoute(
//         path: '/notification',
//         builder: (context, state) => NotificationPage(),
//       ),

//       GoRoute(
//         path: '/dashboard',
//         builder: (context, state) => DashboardWithBottom(),
//       ),
//       GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
//       GoRoute(path: '/createScene', builder: (context, state) => CreateScene()),
//       GoRoute(path: '/device', builder: (context, state) => deviceManagement()),
//       GoRoute(
//         path: '/roomDetail',
//         builder: (context, state) {
//           final roomData = state.extra as Map<String, dynamic>;
//           return RoomDetails(
//             id: roomData['id'] as int,
//             name: roomData['name'] as String,
//             count: roomData['deviceCount'] as int,
//             devices: roomData['devices'] as List<dynamic>,
//             image_path: roomData['image_path'] as String,
//           );
//         },
//       ),
//       GoRoute(
//         path: '/roomDeviceDetail',
//         builder: (context, state) {
//           final devData = state.extra as Map<String, dynamic>;
//           return RoomSingleDevice(
//             deviceName: devData['deviceName'] as String,
//             deviceImageUrl: devData['deviceImageUrl'] as String,
//             isActive: devData['isActive'] as bool,
//             id: devData['id'] as int,
//             roomName: devData['roomName'] as String,
//           );
//         },
//       ),
//     ],
//     redirect: (BuildContext context, GoRouterState state) async {
//       final authService = context.read<AuthService>();
//       if (state.uri.path == '/') return null;
//       if (!authService.isAuthenticated &&
//           state.uri.path != '/Login' &&
//           state.uri.path != '/signup') {
//         return '/Login';
//       }
//       return null;
//     },
//   );

//   // Initialize Firebase Messaging Service
//   final messagingService = FirebaseMessagingService();
//   await messagingService.initialize();
//   messagingService.setRouter(_router); //
//   final String? token = await messagingService.getFcmToken();

//   final RemoteMessage? initialMessage =
//       await FirebaseMessaging.instance.getInitialMessage();
//   if (initialMessage != null) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final route = initialMessage.data['route'] ?? '/notification';
//       _router.go(Uri.parse(route).path); // Parse as URI
//     });
//   }

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthService()),
//         ChangeNotifierProvider(create: (context) => UserProvider()),
//         // ChangeNotifierProvider(create: (context) => IsUserAuthProvider()),
//         ChangeNotifierProvider(create: (context) => SceneProvider()),
//         ChangeNotifierProvider(create: (context) => DeviceProvider()),
//         ChangeNotifierProvider(create: (context) => FcmProvider()),
//         ChangeNotifierProvider(create: (context) => RoomsProvider()),
//         ChangeNotifierProvider(
//           create: (context) {
//             final provider = FcmProvider();
//             if (token != null) {
//               provider.setFcmToken(token);
//             }
//             return provider;
//           },
//         ),
//       ],
//       child: MyApp(messagingService: messagingService, router: _router),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   final FirebaseMessagingService messagingService;
//   final GoRouter router;
//   MyApp({super.key, required this.messagingService, required this.router});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       routerConfig: router,
//     );
//   }
// }

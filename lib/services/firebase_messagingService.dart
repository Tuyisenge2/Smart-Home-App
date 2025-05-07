import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

final api = dotenv.env['EMU_API_URL'];

class FirebaseMessagingService {
  late final FirebaseMessaging _firebaseMessaging;
  late final FlutterLocalNotificationsPlugin _localNotifications;
  late GoRouter _router;
  // Add method to set router after initialization
  void setRouter(GoRouter router) {
    _router = router;
  }

  Future<void> initialize() async {
    await Firebase.initializeApp();

    _firebaseMessaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();

    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap here
        if (response.payload != null) {
          _router.go(response.payload!);
        } else {}
      },

      // onDidReceiveNotificationResponse: (NotificationResponse response) {
      //   if (response.payload != null) {
      //     final data = jsonDecode(response.payload!);
      //     print(
      //       'pPAYYYYYYYYYYYYYYYYYYYYYYYYYYYLOOOOOOOOOOOOOOAAAAAAAAAAAAADDDDDDDDDDDDDd ${response.payload}',
      //     );
      //     _router.go(response.payload!);
      //     if (data['type'] == 'device_status_update') {
      //       _router.go(
      //         data['route'],
      //         extra: {
      //           'deviceName': data['device_name'],
      //           'deviceImageUrl': '', // Add if available
      //           'isActive': data['is_active'],
      //           'id': data['device_id'],
      //           'roomName': '', // You might need to fetch this
      //         },
      //       );
      //     }
      //   }
      // },
    );

    // Create notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Request permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final String? token = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('FCM Token: $token');
      await sendTokenToBackend(token);
    }
    // Set up message handlers
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification tap if needed
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    // Initialize local notifications
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(android: androidDetails),
      payload: '/notification',
      // payload: jsonEncode(data),
    );
  }

  Future<String?> getFcmToken() async {
    return await _firebaseMessaging.getToken();
  }
}

// Keep this background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
    ),
  );

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title,
    message.notification?.body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    payload: message.data['route'] ?? '/notification',
  );
}

Future<void> sendTokenToBackend(String? tok) async {
  try {
    final response = await http.post(
      Uri.parse('$api/fcm-tokens'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'token': tok ?? ''}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print('Token successfully stored in backend');
      }
    } else {
      if (kDebugMode) {
        print('Failed to store token in backend: ${response.body}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error sending token to backend: $e');
    }
  }
}





















// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:rxdart/rxdart.dart';

// class FirebaseMessagingService {
//   // final BehaviorSubject<RemoteMessage> _messageStreamController = 
//   //     BehaviorSubject<RemoteMessage>();
//   // Stream<RemoteMessage> get messageStream => _messageStreamController.stream;

//   late final FirebaseMessaging _firebaseMessaging;
//   late final FlutterLocalNotificationsPlugin _localNotifications;

//   Future<void> initialize() async {
//     await Firebase.initializeApp();
    
//     _firebaseMessaging = FirebaseMessaging.instance;
//     _localNotifications = FlutterLocalNotificationsPlugin();
    
//     // Initialize local notifications
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initializationSettings = 
//         InitializationSettings(android: androidSettings);
//     await _localNotifications.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap if needed
//       },
//     );

//     // Create notification channel for Android
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel', // channel id
//       'High Importance Notifications', // channel name
//       importance: Importance.max,
//     );
//     await _localNotifications
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     // Request permissions
//     final NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       provisional: false,
//     );

//     if (kDebugMode) {
//       print('Notification permissions: ${settings.authorizationStatus}');
//     }

//     // Get and print token
//     final String? token = await _firebaseMessaging.getToken();
//     if (kDebugMode) {
//       print('FCM Token: $token');
      
//     }

//     // Set up message handlers
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // if (kDebugMode) {
//       //   print('Handling a foreground message: ${message.messageId}');
//       //   print('Message data: ${message.data}');
//       //   print('Message notification: ${message.notification?.title}');
//       //   print('Message notification: ${message.notification?.body}');
//       // }
      
//       // Show notification
//       _showNotification(message);
      
//       // Also update UI
//       // _messageStreamController.sink.add(message);
//     });

//     // Handle notification when app is in background but not terminated
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print('Message opened from background: ${message.messageId}');
//       }
//       // _messageStreamController.sink.add(message);
//     });
//   }

//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'high_importance_channel', // same as channel id
//       'High Importance Notifications', // same as channel name
//       channelDescription: 'This channel is used for important notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: true,
//     );
    
//     const NotificationDetails platformDetails = 
//         NotificationDetails(android: androidDetails);
    
//     await _localNotifications.show(
//       message.hashCode, // Unique ID for each notification
//       message.notification?.title,
//       message.notification?.body,
//       platformDetails,
//     );
//   }

//   Future<void> dispose() async {
//     await _messageStreamController.close();
//   }

// Future<String?> getFcmToken() async {
//     try {
//       final token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         // fcmProvider.setFcmToken(token); // Update provider
//         return token;
//       }
//       return null;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error getting FCM token: $e');
//       }
//       return null;
//     }
//   }

// }

// // Background message handler (must be top-level)
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
  
//   // Initialize notifications plugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
  
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
      
//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
      
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   // Show notification
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
  
//   const NotificationDetails platformDetails = 
//       NotificationDetails(android: androidDetails);
  
//   await flutterLocalNotificationsPlugin.show(
//     message.hashCode,
//     message.notification?.title,
//     message.notification?.body,
//     platformDetails,
//   );

//   if (kDebugMode) {
//     print("Handling a background message: ${message.messageId}");
//     print('Message data: ${message.data}');
//     print('Message notification: ${message.notification?.title}');
//     print('Message notification: ${message.notification?.body}');
//   }
// }


























import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/components/back_button.dart';
import 'package:new_app/models/notification_response.dart';
import 'package:new_app/provider/not_provider.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      if (token != null) {
        NotiListResponse response = await fetchNotification(token);
        if (mounted) {
          context.read<NotProvider>().setNotificationData(
            response.notification,
          );
        }
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notData = context.watch<NotProvider>().notificationData ?? [];
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 36.0),
                      child: IconButton(
                        onPressed: () => context.go('/dashboard'),

                        icon: Icon(Icons.arrow_back, size: 20),
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16.0, left: 16),
                      child: Text(
                        'All Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Divider(height: 32, color: Colors.grey[700]),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        'Past Notifications',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        itemCount: notData.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 300,
                            child: _buildNotificationTile(
                              title: notData[index].title ?? 'Notification',
                              subtitle: notData[index].body ?? 'No content',
                              isUnread: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required bool isUnread,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[800],
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[300])),
              ],
            ),
          ),
          if (isUnread)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

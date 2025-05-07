import 'dart:convert';

class NotificationResponse {
  final int id;
  final String title;
  final String body;
  final bool is_ready;
  final int device_id;
  final String? created_at;
  final String? updated_at;

  NotificationResponse({
    required this.id,
    required this.title,
    required this.device_id,
    required this.body,
    required this.is_ready,
    required this.created_at,
    required this.updated_at,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      is_ready: json['is_ready'] ?? false,
      device_id: json['device_id'] ?? 0,
      created_at: json['created_at '],
      updated_at: json['updated_at'],
    );
  }
}

class NotiListResponse {
  final List<NotificationResponse> notification;

  NotiListResponse({required this.notification});

  factory NotiListResponse.fromJson(List<dynamic> json) {
    return NotiListResponse(
      notification:
          json
              .map((roomJson) => NotificationResponse.fromJson(roomJson))
              .toList(),
    );
  }
}

// ignore_for_file: non_constant_identifier_names


class FetchSceneResponse {
  final int id;
  final String name;
  final List<String> days_of_week;
  final String start_time;
  final String end_time;
  final bool send_notification;
  final List<dynamic> devices;
  final bool is_active;
  final String? created_at;
  final String? updated_at;
  final int user_id;

  @override
  String toString() {
    return '''
FetchSceneResponse {
  id: $id,
  name: $name,
  days_of_week: $days_of_week,
  start_time: $start_time,
  end_time: $end_time,
  send_notification: $send_notification,
  devices: $devices,
  is_active: $is_active,
  created_at: $created_at,
  updated_at: $updated_at,
  user_id: $user_id
}''';
  }

  FetchSceneResponse({
    required this.id,
    required this.name,
    required this.days_of_week,
    required this.start_time,
    required this.end_time,
    required this.send_notification,
    required this.devices,
    required this.is_active,
    required this.user_id,
    this.created_at,
    this.updated_at,
  });

  factory FetchSceneResponse.fromJson(Map<String, dynamic> json) {
    return FetchSceneResponse(
      id: json['id'],
      name: json['name'],
      days_of_week: List<String>.from(json['days_of_week']),
      start_time: json['start_time'],
      end_time: json['end_time'],
      send_notification: json['send_notification'],
      devices: json['devices'],
      is_active: json['is_active'],
      user_id: json['user_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}



class SceneListResponse {
  final List<FetchSceneResponse> scenes;

  SceneListResponse({required this.scenes});

  factory SceneListResponse.fromJson(Map<String, dynamic> json) {
    return SceneListResponse(
      scenes:
          (json['scenes'] as List<dynamic>)
              .map((sceneJson) => FetchSceneResponse.fromJson(sceneJson))
              .toList(),
    );
  }
}

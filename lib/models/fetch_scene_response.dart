// ignore_for_file: non_constant_identifier_names

// ignore_for_file: non_constant_identifier_names

class FetchSceneResponse {
  final int id;
  final String name;
  final List<String> days_of_week;
  final String start_time;
  final String end_time;
  final bool send_notification;
  final Map<String, dynamic> device_states;
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
  device_states: $device_states,
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
    required this.device_states,
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
      device_states: json['device_states'],
      is_active: json['is_active'],
      user_id: json['user_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

// class FetchSceneResponse {
//   final int id;
//   final String name;
//   final List<String> days_of_week;
//   final String start_time;
//   final String end_time;
//   final bool send_notification;
//   final Map<String, dynamic> device_states;
//   final bool is_active;
//   final String? created_at;
//   final String? updated_at;
//   final int user_id;

//   FetchSceneResponse({
//     required this.id,
//     required this.is_active,
//     required this.name,
//     required this.days_of_week,
//     required this.device_states,
//     required this.send_notification,
//     required this.start_time,
//     required this.end_time,
//     required this.user_id,
//     this.created_at,
//     this.updated_at,
//   });

//   factory FetchSceneResponse.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'id': int id,
//         'name': String name,
//         'days_of_week': List<String> days_of_week,
//         'start_time': String start_time,
//         'end_time': String end_time,
//         'send_notification': bool send_notification,
//         'device_states': Map<String, dynamic> device_states,
//         'is_active': bool is_active,
//         'created_at': String? created_at,
//         'updated_at': String? updated_at,
//         'user_id': int user_id,
//       } =>
//         FetchSceneResponse(
//           id: id,
//           name: name,
//           days_of_week: days_of_week,
//           start_time: start_time,
//           end_time: end_time,
//           send_notification: send_notification,
//           device_states: device_states,
//           is_active: is_active,
//           user_id: user_id,
//           created_at: created_at,
//           updated_at: updated_at,
//         ),
//       _ => throw const FormatException("failed to load scene"),
//     };
//   }
// }

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

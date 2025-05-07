// ignore_for_file: non_constant_identifier_names

class FetchRoomsResponse {
  final int id;
  final String name;
  final String image_path;
  final List<Map<String, dynamic>>? devices;
  final String? created_at;
  final String? updated_at;

  FetchRoomsResponse({
    required this.id,
    required this.name,
    required this.image_path,
    required this.devices,
    required this.created_at,
    required this.updated_at,
  });

  factory FetchRoomsResponse.fromJson(Map<String, dynamic> json) {
    return FetchRoomsResponse(
      id: json['id'],
      name: json['name'],
      devices: List<Map<String, dynamic>>.from(json['devices']),
      image_path: json['image_path'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

class RoomListResponse {
  final List<FetchRoomsResponse> rooms;

  RoomListResponse({required this.rooms});

  factory RoomListResponse.fromJson(List<dynamic> json) {
    return RoomListResponse(
      rooms:
          json
              .map((roomJson) => FetchRoomsResponse.fromJson(roomJson))
              .toList(),
    );
  }
}

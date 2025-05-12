// ignore_for_file: non_constant_identifier_names

class FetchDeviceResponse {
  final int id;
  final String Device_name;
  final Map<String, dynamic> Device_room;
  final String images_url;
  final bool is_active;

  @override
  String toString() {
    return '''
FetchDeviceResponse {
  id: $id,
  Device_name: $Device_name,
  Device_room: $Device_room,
  images_url: $images_url,
  is_active: $is_active,
}''';
  }

  FetchDeviceResponse({
    required this.id,
    required this.Device_name,
    required this.Device_room,
    required this.images_url,
    required this.is_active,
  });

  factory FetchDeviceResponse.fromJson(Map<String, dynamic> json) {
    return FetchDeviceResponse(
      id: json['id'],
      Device_name: json['Device_name'],
      Device_room: Map<String, dynamic>.from(json['Device_room']),
      images_url: json['images_url,'] ?? '',
      is_active: (json['is_active'] ?? 0) == 1,
    );
  }
}

class DeviceListResponse {
  final List<FetchDeviceResponse> devices;

  DeviceListResponse({required this.devices});

  factory DeviceListResponse.fromJson(Map<String, dynamic> json) {
    return DeviceListResponse(
      devices:
          (json['data'] as List<dynamic>)
              .map((deviceJson) => FetchDeviceResponse.fromJson(deviceJson))
              .toList(),
    );
  }
}

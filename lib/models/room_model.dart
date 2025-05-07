class RoomModel {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final int deviceCount;

  RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.deviceCount,
  });

  // From JSON
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['image_path'] ?? '', // Optional from backend
      deviceCount: json['device_count'] ?? 0, // Optional from backend
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_path': imagePath,
      'device_count': deviceCount,
    };
  }
}

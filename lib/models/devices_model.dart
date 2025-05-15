// class DevicesModel {
//   final int id;
//   final String name;
//   final String room;
//   final String? image;

//   DevicesModel({
//     required this.id,
//     required this.name,
//     required this.room,
//     this.image,
//   });

//   factory DevicesModel.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'id': int id,
//         'Device_name': String name,
//         'Device_room': String room,
//         'images_url': String? image,
//       } =>
//         DevicesModel(id: id, name: name, room: room,image: image),
//       _ => throw const FormatException("failed to load device"),
//     };
//   }
// }

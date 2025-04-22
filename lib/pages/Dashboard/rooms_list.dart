// room_list.dart

import 'package:flutter/material.dart';
import 'package:new_app/pages/Dashboard/Widgets/room_sheet.dart';
import 'package:new_app/pages/Dashboard/Widgets/room_success.dart';
import 'package:new_app/pages/Dashboard/Widgets/rooms_card.dart';
import 'package:new_app/pages/Dashboard/Widgets/rooms_image.dart';

// Room model
class Room {
  final String imagePath;
  final String title;
  final int deviceCount;

  Room({
    required this.imagePath,
    required this.title,
    required this.deviceCount,
  });
}

// Room list widget
class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final List<Room> rooms = [
    Room(imagePath: 'assets/images/livingRoom.jpg', title: 'Living Room', deviceCount: 5),
    Room(imagePath: 'assets/images/bedRoom.jpg', title: 'Bedroom', deviceCount: 4),
    Room(imagePath: 'assets/images/bedroom2.jpeg', title: 'Bedroom 2', deviceCount: 4),
    Room(imagePath: 'assets/images/kitchen.jpg', title: 'Kitchen', deviceCount: 2),
  ];

  void _addRoom(Room room) {
    setState(() {
      rooms.add(room);
    });
  }

  Future<void> _showAddRoomSheet(BuildContext context) async {
    final roomName = await showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const AddRoomSheet(),
);


    if (roomName != null && roomName.isNotEmpty) {
      final imagePath = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const SelectRoomImageSheet(),
      );

      if (imagePath != null && imagePath.isNotEmpty) {
        final newRoom = Room(imagePath: imagePath, title: roomName, deviceCount: 0);
        _addRoom(newRoom);

        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RoomSuccessSheet(roomName: roomName),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Room "$roomName" created!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Grid of Rooms
        Expanded(
          child: GridView.builder(
            itemCount: rooms.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final room = rooms[index];
              return RoomCard(
                imagePath: room.imagePath,
                title: room.title,
                deviceCount: room.deviceCount,
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // Create Room Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showAddRoomSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBDFD44),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Create Room'),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

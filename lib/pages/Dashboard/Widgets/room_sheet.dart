import 'package:flutter/material.dart';

class AddRoomSheet extends StatelessWidget {
  final void Function(String roomName)? onRoomAdded;

  const AddRoomSheet({super.key, this.onRoomAdded});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1F2A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close icon
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.greenAccent,
                child: Icon(Icons.close, color: Colors.black, size: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Room Name',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),

          // Input field
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Tv Lounge',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF2C2D35),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () => controller.clear(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.limeAccent[400],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
               onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('Continue'),
            ),
          ),

          const SizedBox(height: 12),

          // Back button
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back', style: TextStyle(color: Colors.greenAccent)),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final int deviceCount;

  const RoomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.deviceCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D3E),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              child: Icon(Icons.info_outline, size: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$deviceCount Device${deviceCount == 1 ? '' : 's'}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFFBDFD44),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

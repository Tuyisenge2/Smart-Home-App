import 'package:flutter/material.dart';

class SelectRoomImageSheet extends StatefulWidget {
  const SelectRoomImageSheet({super.key});

  @override
  State<SelectRoomImageSheet> createState() => _SelectRoomImageSheetState();
}

class _SelectRoomImageSheetState extends State<SelectRoomImageSheet> {
  int selectedIndex = -1;

  final List<String> imagePaths = [
    'assets/images/bedRoom.jpg',
    'assets/images/livingRoom.jpg',
    'assets/images/bedroom2.jpeg',
    'assets/images/kitchen.jpg',
    
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1B1D2A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 14,
                  child: Icon(Icons.close, size: 16, color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),

          // Grid of Images
          GridView.builder(
            shrinkWrap: true,
            itemCount: imagePaths.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePaths[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (isSelected)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 12,
                          child: Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedIndex != -1 ? () {
                // Pass back selected image path
                Navigator.of(context).pop(imagePaths[selectedIndex]);
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBDFD44),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('CONTINUE'),
            ),
          ),

          const SizedBox(height: 8),

          // Back Text
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Text('BACK', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}

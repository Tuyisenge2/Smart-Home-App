import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlusButton extends StatelessWidget {
  final double height;
  final double width;
  final String path;
  const PlusButton({required this.height, required this.width, this.path='/'});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(path);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text('+', style: TextStyle(height: 1, fontSize: height)),
        ),
      ),
    );
  }
}

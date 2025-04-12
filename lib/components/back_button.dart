import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonComponent extends StatelessWidget {
  final String route;
  final double size;
  final Color iconColor;
  const BackButtonComponent({
    Key? key,
    required this.route,
    this.size = 30,
    this.iconColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      //   onPressed: () => context.go(route),
      onPressed: () => context.pop(),

      icon: Icon(Icons.arrow_back, size: size),
      color: iconColor,
    );
  }
}

import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontweight;

  const ResponsiveText({
    super.key,
    required this.textColor,
    required this.fontSize,
    required this.text,
    this.fontweight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontweight,
          ),
        ),
      ),
    );
  }
}

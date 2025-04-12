import 'package:flutter/material.dart';

class Customizedbutton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color buttonColor;
  final Function bottomModal;
  const Customizedbutton({
    this.bottomModal = defaultFuntion,
    required this.label,
    required this.labelColor,
    required this.buttonColor,
  });
  static defaultFuntion() {}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomModal();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

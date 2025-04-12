import 'package:flutter/material.dart';

class TimesButton extends StatelessWidget {
  final double height;
  final double width;
  final Function callback;
  const TimesButton({
    required this.height,
    required this.width,
    this.callback = defaultFun,
  });
  static defaultFun() {}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFFB9F249),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text('×', style: TextStyle(height: 1, fontSize: height)),
        ),
      ),
    );
  }
}

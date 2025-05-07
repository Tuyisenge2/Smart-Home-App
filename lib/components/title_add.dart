import 'package:flutter/material.dart';
import 'package:new_app/components/plus_button.dart';

class TitleAdd extends StatelessWidget {
  final String firstLabel;
  final String AddLabel;
  const TitleAdd({required this.firstLabel, required this.AddLabel});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstLabel,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlusButton(height: 15, width: 15),
              Text(
                AddLabel,
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

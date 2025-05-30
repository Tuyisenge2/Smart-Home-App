import 'package:flutter/material.dart';
import 'package:new_app/components/plus_button.dart';

class TitleAdd extends StatelessWidget {
  final String firstLabel;
  final String AddLabel;
  final VoidCallback? onTap;
  const TitleAdd({
    required this.firstLabel, 
    required this.AddLabel,
    this.onTap,
    });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstLabel,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        GestureDetector(
          onTap: onTap,
        
        child: Container(
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
        ),
      ],
    );
  }
}

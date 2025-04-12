import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return
     SizedBox(
      height: 90,
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.6,
        child: Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.dashboard, color: Colors.black),
                      SizedBox(width: 10,),
                      Text(
                        'Home',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(child: SvgPicture.asset('assets/icons/Group.svg')),
              InkWell(child: SvgPicture.asset('assets/icons/user2.svg')),
            ],
          ),
        ),
      ),
    );
  }
}

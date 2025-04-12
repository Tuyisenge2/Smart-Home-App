import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeviceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 170,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 140.0),
            child: InkWell(child: SvgPicture.asset('assets/icons/less2.svg')),
          ),
          Image.asset('assets/images/AirCond.png'),
          Text(
            "Air Conditioner",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "3 devices",
            style: TextStyle(fontSize: 13, color: Colors.white, height: 1),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 110.0),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset('assets/icons/toggleButton.svg'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DeviceCard3 extends StatefulWidget {
  const DeviceCard3({super.key});

  @override
  _DeviceCard3State createState() => _DeviceCard3State();
}

class _DeviceCard3State extends State<DeviceCard3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 165,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/AirCond.png'),
          Text(
            "Air Conditioner",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "3 devices",
            style: TextStyle(fontSize: 14, color: Colors.grey, height: 1),
          ),
        ],
      ),
    );
  }
}

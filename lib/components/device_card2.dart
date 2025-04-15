import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeviceCard2 extends StatefulWidget {
  const DeviceCard2({super.key});

  @override
  _DeviceCard2State createState() => _DeviceCard2State();
}

class _DeviceCard2State extends State<DeviceCard2> {
  bool isToggleOn = false;
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: Image.asset('assets/images/AirCond.png')),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 90.0),
                  child: InkWell(
                    child: SvgPicture.asset('assets/icons/less2.svg'),
                  ),
                ),
                SizedBox(height: 11),
                Text(
                  "Air Conditioner",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "3 devices",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1,
                  ),
                ),

                SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.only(left: 59.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isToggleOn = !isToggleOn;
                      });
                    },
                    child:
                        isToggleOn
                            ? SvgPicture.asset('assets/icons/toggleButtonOn.svg')
                            : SvgPicture.asset(
                              'assets/icons/toggleButton.svg',
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

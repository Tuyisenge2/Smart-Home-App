import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoomsComponent extends StatelessWidget {
  final String roomName;
  final int deviceCount;
  final String isRoomorHome;
  const RoomsComponent({
    required this.roomName,
    required this.deviceCount,
    required this.isRoomorHome,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/livingRoom.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          isRoomorHome == 'Room'
              ? Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset('assets/icons/toggleButton.svg'),
                ),
              )
              : Text(''),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  height: 65,
                  width: 274,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            roomName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                deviceCount < 2
                                    ? '$deviceCount Device'
                                    : '$deviceCount Devices',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/icons/less2.svg',
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isRoomorHome == 'Home'
                          ? InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/toggleButton.svg',
                            ),
                          )
                          : Text(''),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

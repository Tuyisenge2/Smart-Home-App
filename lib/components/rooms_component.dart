import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:provider/provider.dart';

class RoomsComponent extends StatelessWidget {
  final String roomName;
  final int deviceCount;
  final int id;
  final String isRoomorHome;
  final List<dynamic> devices;
  final String image_path;
  const RoomsComponent({
    super.key,
    required this.roomName,
    required this.deviceCount,
    required this.isRoomorHome,
    required this.id,
    required this.devices,
    required this.image_path,
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
          image: NetworkImage(image_path),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.push(
                                '/roomDetail',
                                extra: {
                                  'id': id,
                                  'name': roomName,
                                  'deviceCount': deviceCount,
                                  'devices': devices,
                                  'image_path':image_path
                                },
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  deviceCount < 2
                                      ? '$deviceCount Device'
                                      : '$deviceCount Devices',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/icons/less2.svg',
                                  height: 10,
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

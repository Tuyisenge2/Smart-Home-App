// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/provider/device_provider.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/services/fetchDevice.dart' show deviceUtils;
import 'package:new_app/services/fetch_service.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceCard extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool isActive;
  final int id;
  final String roomName;
  const DeviceCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isActive,
    required this.id,
    required this.roomName,
  });
  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 140.0),
            child: InkWell(
              onTap: () {
                context.push(
                  '/roomDeviceDetail',
                  extra: {
                    'deviceName': widget.name,
                    'deviceImageUrl': widget.imageUrl,
                    'isActive': widget.isActive,
                    'id': widget.id,
                    'roomName': widget.roomName,
                  },
                );
              },
              child: SvgPicture.asset('assets/icons/less2.svg'),
            ),
          ),
          //   Image.asset( widget.imageUrl?? 'assets/images/AirCond.png'),
          // Image.network(widget.imageUrl, height: 50, width: 120),
          buildImageWidget(),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 110.0),
            child: InkWell(
              onTap: () async {
                try {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  String? token = pref.getString('token');

                  dynamic res = await updateDevice(
                    token!,
                    !widget.isActive,
                    widget.id,
                  );
                  await deviceUtils.getDevicesData(context);
                  showTopSnackBar(
                    context,
                    'Device updated successful!',
                    Colors.green,
                  );
                } catch (e) {
                  print('Error updating device: $e');
                  throw Exception('Error updating device');
                }
              },
              child:
                  widget.isActive
                      ? SvgPicture.asset('assets/icons/toggleButtonOn.svg')
                      : SvgPicture.asset('assets/icons/toggleButton.svg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageWidget() {
    return SizedBox(
      height: 50,
      width: 120,
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/defaultImage.png');
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
      ),
    );
  }
}

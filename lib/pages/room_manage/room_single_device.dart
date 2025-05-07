import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/provider/device_provider.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/services/fetchDevice.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomSingleDevice extends StatefulWidget {
  final String deviceName;
  final String deviceImageUrl;
  final bool isActive;
  final int id; // Assuming you have an ID for the device
  final String roomName;
  RoomSingleDevice({
    super.key,
    required this.deviceName,
    required this.deviceImageUrl,
    required this.isActive,
    required this.id,
    required this.roomName,
  });

  @override
  State<RoomSingleDevice> createState() => _RoomSingleDeviceState();
}

class _RoomSingleDeviceState extends State<RoomSingleDevice> {
  int Intensity = 1;

  dynamic _getRoomName(List<dynamic> roomData, List<dynamic> deviceData) {
    try {
      final device = deviceData.firstWhere(
        (device) => device.Device_name == widget.deviceName,
      );

      final int roomId = device.Device_room;

      final room = roomData.firstWhere((room) => room.id == roomId);
      return room;
    } catch (e) {
      print('Error finding room for device "${widget.deviceName}": $e');
      return 'Unknown Room';
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic roomData = context.read<RoomsProvider>().roomData;
    dynamic deviceData = context.read<DeviceProvider>().deviceData;
    final displayRoom = _getRoomName(roomData, deviceData);
    print(
      'sQWWWWWWWWWWWEEEEEEEEEEEEERRRRRRTYYYYYYYYYYYTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT ${displayRoom.image_path}',
    );

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: MediaQuery.sizeOf(context).height * 0.03,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          displayRoom.image_path,
                        ), //AssetImage('assets/images/livingRoom.jpg') ,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 65,
                            width: 274,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF31373C),
                                    borderRadius: BorderRadius.circular(70),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                      fit: BoxFit.contain,
                                      'assets/icons/greaterThan.svg',
                                      height: 1,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    widget.roomName == ''
                                        ? displayRoom.name
                                        : widget.roomName, // "Living Room",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF181D23),
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.7],
                                  tileMode: TileMode.mirror,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              widget.deviceName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 400,
                    child: Image.network(
                      widget.deviceImageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
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
                              ? SvgPicture.asset(
                                'assets/icons/toggleButtonOn.svg',
                              )
                              : SvgPicture.asset(
                                'assets/icons/toggleButton.svg',
                              ),
                    ),
                  ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: MediaQuery.of(context).size.width * 0.04,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 3,
                  //         child: Text(
                  //           'Schedule',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w800,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Text(
                  //           '20%',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 24,
                  //             fontWeight: FontWeight.w800,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: MediaQuery.of(context).size.width * 0.04,
                  //   ),

                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'From',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.03,
                  //       ),
                  //       Text(
                  //         '12.00',
                  //         style: TextStyle(
                  //           color: Color(0xFFB9F249),
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w800,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.009,
                  //       ),

                  //       Text(
                  //         'AM',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.01,
                  //       ),

                  //       Transform.rotate(
                  //         angle: 90 * (3.1415926535 / -180),
                  //         child: SvgPicture.asset(
                  //           'assets/icons/greaterThan.svg',
                  //           height: 10,
                  //           width: 10,
                  //           fit: BoxFit.contain,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.04,
                  //       ),

                  //       Text(
                  //         'TO',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.03,
                  //       ),
                  //       Text(
                  //         '12.00',
                  //         style: TextStyle(
                  //           color: Color(0xFFB9F249),
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w800,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.009,
                  //       ),

                  //       Text(
                  //         'AM',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.01,
                  //       ),

                  //       Transform.rotate(
                  //         angle: 90 * (3.1415926535 / -180),
                  //         child: SvgPicture.asset(
                  //           'assets/icons/greaterThan.svg',
                  //           height: 10,
                  //           width: 10,
                  //           fit: BoxFit.contain,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: MediaQuery.of(context).size.width * 0.04,
                  //   ),
                  //   child: Text(
                  //     'Intensity',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.w800,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Slider(
                  //   value: Intensity.toDouble(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       Intensity = value.toInt();
                  //     });
                  //   },
                  //   min: 0,
                  //   max: 100,
                  //   activeColor: Color(0xFFB9F249),
                  //   thumbColor: Colors.white,
                  // ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: MediaQuery.of(context).size.width * 0.06,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         height: 20,
                  //         width: 2,
                  //         color: Color(0xFFB9F249),
                  //       ),
                  //       Container(
                  //         height: 20,
                  //         width: 2,
                  //         color: Color(0xFFB9F249),
                  //       ),
                  //       Container(
                  //         height: 20,
                  //         width: 2,
                  //         color: Color(0xFFB9F249),
                  //       ),
                  //       Container(
                  //         height: 20,
                  //         width: 2,
                  //         color: Color(0xFFB9F249),
                  //       ),
                  //       Container(
                  //         height: 20,
                  //         width: 2,
                  //         color: Color(0xFFB9F249),
                  //       ),
                  //       Container(
                  //         height: 20,
                  //         width: 2,
                  //         color: Color(0xFFB9F249),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.06),

                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   child: Customizedbutton(
                  //     label: 'Save',
                  //     labelColor: Colors.black,
                  //     buttonColor: Color(0xFFB9F249),
                  //     bottomModal: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //   ),
                  // ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

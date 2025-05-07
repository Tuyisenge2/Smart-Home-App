// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/components/device_card.dart';
import 'package:new_app/components/plus_button.dart';
import 'package:new_app/components/rooms_component.dart';
import 'package:new_app/components/scene_card.dart';
import 'package:new_app/components/title_add.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/models/fetch_rooms_response.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/provider/device_provider.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/provider/scene_provider.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashHome extends StatefulWidget {
  const DashHome({super.key});
  @override
  _DashHomeState createState() => _DashHomeState();
}

class _DashHomeState extends State<DashHome> {
  @override
  void initState() {
    super.initState();
    getSceneData();
    getDevicesData();
    getRoomData();
  }

  void getSceneData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      dynamic sceneData = context.read<SceneProvider>().sceneData;
      if (token != null) {
        SceneListResponse response = await fetchScenes(token);
        context.read<SceneProvider>().setSceneData(response.scenes);
      }
    } catch (e) {
      print('Error fetching scene data: mana $e');
      context.push('/Login');
    }
  }

  void getDevicesData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      dynamic deviceData = context.read<DeviceProvider>().deviceData;
      if (token != null && deviceData.isEmpty) {
        DeviceListResponse response = await fetchDevice(token);
        context.read<DeviceProvider>().setDeviceData(response.devices);
      }
    } catch (e) {
      print('Error fetching device data: Error is $e');
    }
  }

  void getRoomData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      dynamic roomData = context.read<RoomsProvider>().roomData;
      if (token != null && roomData.isEmpty) {
        RoomListResponse response = await fetchRooms(token);
        context.read<RoomsProvider>().setRoomData(response.rooms);
      }
    } catch (e) {
      print('Error fetching device data: Error is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic sceneData = context.watch<SceneProvider>().sceneData;
    dynamic deviceData = context.watch<DeviceProvider>().deviceData;
    dynamic roomData = context.watch<RoomsProvider>().roomData;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      spacing: 3,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.655),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            '24°C',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                right: 17,
                                              ),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  width: 35,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'normal',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              'assets/icons/sunCloud.svg',
                                              height: 50,
                                              width: 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: Text(
                                      'Temperature',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: Text(
                                      'Kigali,RWANDA',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: Text(
                                      'Thu,12:00, Mostly Cloudly',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.655),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Text(
                                              'Electricity',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Text(
                                              'Usage',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 75,
                                              ),
                                              child: Text(
                                                'Kwh',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w800,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Center(
                                              child: Text(
                                                '34.5',
                                                style: TextStyle(
                                                  fontSize: 27,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w900,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.655),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Text(
                                              'Electricity',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Text(
                                              'Cost',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.85,
                                            child: Center(
                                              child: Text(
                                                '\$345',
                                                style: TextStyle(
                                                  fontSize: 27,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w900,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Scenes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  PlusButton(height: 24, width: 24, path: '/createSCene'),
                ],
              ),
              SizedBox(height: 10),

              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    sceneData.isEmpty
                        ? SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'No Scene Found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                        :
                         ListView.builder(
                          itemCount: sceneData?.length ?? 0,
                          itemBuilder: (context, index) {
                            final currentScene = sceneData[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: SceneCard(
                                sceneMess: currentScene.name,
                                iconPath:
                                    currentScene.name.toLowerCase().contains(
                                          'morning',
                                        )
                                        ? 'assets/icons/sun.svg'
                                        : 'assets/icons/moon.svg',
                                togglePath: 'assets/icons/toggleButton.svg',
                                isActive: currentScene.is_active,
                                id: currentScene.id,
                              ),
                            );
                          },
                        ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  context.push('/device');
                },
                child: TitleAdd(
                  firstLabel: 'My Device',
                  AddLabel: 'Add Device',
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (deviceData.length / 2).ceil(),
                      itemBuilder: (context, rowIndex) {
                        final firstIndex = rowIndex * 2;
                        return
                        
                         Padding(
                          padding: EdgeInsets.only(right: 0, left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeviceCard(
                                name: deviceData[firstIndex].Device_name,
                                imageUrl:
                                    deviceData[firstIndex].images_url != ''
                                        ? deviceData[firstIndex].images_url
                                        : 'assets/images/AirCond.png',
                                id: deviceData[firstIndex].id,
                                isActive: deviceData[firstIndex].is_active,
                                roomName: '',
                              ),
                              SizedBox(width: 8),
                              if (firstIndex + 1 < deviceData.length)
                                DeviceCard(
                                  id: deviceData[firstIndex + 1].id,
                                  name: deviceData[firstIndex + 1].Device_name,
                                  imageUrl:
                                      deviceData[firstIndex].images_url != ''
                                          ? deviceData[firstIndex].images_url
                                          : 'assets/images/AirCond.png',
                                  isActive:
                                      deviceData[firstIndex + 1].is_active,
                                  roomName: '',
                                ),
                              SizedBox(width: 8),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              SizedBox(height: 20),
              TitleAdd(firstLabel: 'My Room', AddLabel: 'Add Rooms'),
              SizedBox(height: 15),
              Column(
                spacing: 15,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomData.length ?? 0,
                      itemBuilder: (contetx, rowIndex) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: RoomsComponent(
                            roomName: roomData[rowIndex].name ?? 'Living Room',
                            deviceCount: roomData[rowIndex].devices.length ?? 2,
                            isRoomorHome: 'Home',
                            id: roomData[rowIndex].id,
                            devices: roomData[rowIndex].devices,
                            image_path:
                                roomData[rowIndex].image_path, //images_path
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    )
    //  bottomNavigationBar: BottomNavigation(),
    // )
    ;
  }
}

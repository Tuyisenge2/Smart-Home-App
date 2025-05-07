// ignore_for_file: non_constant_identifier_names, camel_case_types, library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/device_card.dart';
import 'package:new_app/components/times_button.dart';
import 'package:new_app/helper/sql_helper.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/models/fetch_rooms_response.dart';
import 'package:new_app/provider/device_provider.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/services/create_service.dart';
import 'package:new_app/services/fetchDevice.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:new_app/util/cloudinary_utils.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class deviceManagement extends StatefulWidget {
  const deviceManagement({super.key});

  @override
  _deviceManagementState createState() => _deviceManagementState();
}

class _deviceManagementState extends State<deviceManagement> {
  CloudinaryUtils cloud = CloudinaryUtils();
  String name = '';
  int room_id = 0;
  bool livRoom = false;
  File? _imageFile;
  String images_url = '';
  bool showUploadingButtonImage = false;
  bool isUploadingImage = false;
  bool isCreatingDevice = false;
  List<Map<String, dynamic>> currentDevice = [];
  bool hasExistingData = false;

  void fetchDataSqlLite() async {
    final data = await SQLHelper.getDevices();
    setState(() {
      currentDevice = data;
      if (data.isNotEmpty) {
        final firstDevice = data.first;
        name = firstDevice['name'] ?? '';
        room_id = firstDevice['roomId'] ?? 0;
        images_url = firstDevice['imageUrl'] ?? '';
        livRoom = room_id == 1;
        hasExistingData = currentDevice.isNotEmpty;
        print(
          '${currentDevice[0]}  $name $room_id  second image deleteyyyyyyyyyooooooooooppppppppppppppqqqqqqqqqqqqqqqqqqqqqqq',
        );
      }
    });
  }

  void getDevicesData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      dynamic deviceData = context.read<DeviceProvider>().deviceData;
      if (token != null) {
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
      if (token != null) {
        RoomListResponse response = await fetchRooms(token);
        context.read<RoomsProvider>().setRoomData(response.rooms);
      
      }
    } catch (e) {
      print('Error fetching device data: Error is $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataSqlLite();
  }

  void bottomModal() {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TimesButton(
                        height: 20,
                        width: 20,
                        callback: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "Device Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (_imageFile != null) ...[
                    Container(
                      width: 80,
                      height: 80,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      //
                      child: Image.file(_imageFile!),
                      // SvgPicture.asset('assets/icons/sun.svg'),
                    ),
                  ],
                  pickImageButton(
                    ImageSource.camera,
                    'Take a Photo',
                    setModalState,
                  ),
                  pickImageButton(
                    ImageSource.gallery,
                    'Select from Your Gallery',
                    setModalState,
                  ),
                  showUploadingButtonImage
                      ? isUploadingImage
                          ? uploadingButton(
                            Color(0xFFB9F249),
                            Colors.black,
                            ' uploading ',
                          )
                          : Customizedbutton(
                            label: 'Upload Image',
                            labelColor: Colors.black,
                            buttonColor: Color(0xFFB9F249),
                            bottomModal: () async {
                              setModalState(() {
                                isUploadingImage = true;
                              });
                              images_url =
                                  await cloud.uploadImage(_imageFile!) ?? '';
                              hasExistingData
                                  ? await _updateDevice(
                                    null,
                                    null,
                                    null,
                                    currentDevice[0]['imageUrl'],
                                    images_url,
                                  )
                                  : await _addDevice('', 0, images_url);
                              setModalState(() {
                                showUploadingButtonImage =
                                    !showUploadingButtonImage;
                                isUploadingImage = false;
                                _imageFile = null;
                              });
                              Navigator.of(context).pop();
                              //Future.delayed(Duration(milliseconds: 300), () {
                              creatSceneSecondModal();
                              //});
                            },
                          )
                      : SizedBox.shrink(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void EditImageModal() {
    // print(
    //   'second image rurlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll $currentDevice',
    // );
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TimesButton(
                        height: 20,
                        width: 20,
                        callback: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "Selected Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  if (hasExistingData) ...[
                    // Show existing device info
                    Container(
                      width: 80,
                      height: 80,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:
                          images_url.isNotEmpty
                              ? Image.network(images_url)
                              : Icon(Icons.device_hub, color: Colors.white),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Room: ${room_id == 1 ? 'Living Room' : 'Other'}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                  Customizedbutton(
                    label: 'Continue',
                    labelColor: Colors.black,
                    buttonColor: Color(0xFFB9F249),
                    bottomModal: () {
                      Navigator.of(context).pop();
                      creatSceneSecondModal();
                    },
                  ),
                  Customizedbutton(
                    label: 'Edit',
                    labelColor: Colors.black,
                    buttonColor: Color(0xFFB9F249),
                    bottomModal: () {
                      Navigator.of(context).pop();
                      bottomModal();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _addDevice(String name, int roomId, String imageUrl) async {
    final res = await SQLHelper.createDevice(name, roomId, imageUrl);
    fetchDataSqlLite();
  }

  Future<void> _updateDevice(
    int? id,
    String? name,
    int? roomId,
    String? imageUrl,
    String? newImageUrl,
  ) async {
    await SQLHelper.updateDevice(id, name, roomId, imageUrl, newImageUrl);
    fetchDataSqlLite();
  }

  void _deleteDevice(String imageUrl) async {
    await SQLHelper.deleteDevice(imageUrl);
    fetchDataSqlLite();
  }

  void creatSceneSecondModal() {
    dynamic roomData = context.read<RoomsProvider>().roomData;

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TimesButton(
                        height: 20,
                        width: 20,
                        callback: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "Select Room",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                      itemCount: roomData.length ?? 0,
                      itemBuilder: (contetx, rowIndex) {
                        final isSelected = room_id == roomData[rowIndex].id;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: InkWell(
                            onTap: () async {
                              setModalState(() {
                                room_id = roomData[rowIndex].id;
                              });
                              await _updateDevice(
                                2,
                                null,
                                room_id,
                                images_url,
                                null,
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 190,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Color(0xFFB9F249)
                                        : Color(0xFF181D23),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  roomData[rowIndex].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Customizedbutton(
                    label: 'Continue',
                    labelColor: Colors.black,
                    buttonColor: Color(0xFFB9F249),
                    bottomModal: () {
                      Navigator.of(context).pop();
                      createSceneThirdModal();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void createSceneThirdModal() {
    TextEditingController nameController = TextEditingController(text: name);

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TimesButton(
                        height: 20,
                        width: 20,
                        callback: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          "Device Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: Color(0xFFB9F249),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 8,
                              child: TextField(
                                controller: nameController,
                                onChanged: (value) async {
                                  setState(() {
                                    name = value;
                                  });
                                  await _updateDevice(
                                    null,
                                    value,
                                    null,
                                    images_url,
                                    null,
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: name,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ), // Border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ), // Border color
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isCreatingDevice
                      ? uploadingButton(
                        Color(0xFFB9F249),
                        Colors.black,
                        'Continue',
                      )
                      : Customizedbutton(
                        label: 'Continue',
                        labelColor: Colors.black,
                        buttonColor: Color(0xFFB9F249),
                        bottomModal: () async {
                          try {
                            setState(() {
                              isCreatingDevice = true;
                            });
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            final token = pref.getString('token');
                            final response = await createDevice(
                              name,
                              room_id,
                              images_url,
                              token!,
                            );
                            if (response['status'] == true) {
                              setState(() {
                                isCreatingDevice = false;
                              });
                              showTopSnackBar(
                                context,
                                'Device created successful!',
                                Colors.green,
                              );
                              _deleteDevice(images_url);
                              hasExistingData = false;
                              _resetFormData();
                              Navigator.of(context).pop();
                              getDevicesData();
                              getRoomData();
                              createSceneFoufthModal(name);
                            }
                          } catch (e) {
                            print('Error creating device: $e');
                            showTopSnackBar(
                              context,
                              'Device creation Failed!',
                              Colors.red,
                            );
                          }
                        },
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void createSceneFoufthModal(String name) {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TimesButton(
                    height: 20,
                    width: 20,
                    callback: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Center(child: SvgPicture.asset("assets/icons/tick1.svg")),

              Column(
                children: [
                  Text(
                    "$name added to ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    "\"room 1\" ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              Customizedbutton(
                label: 'DONE',
                labelColor: Colors.black,
                buttonColor: Color(0xFFB9F249),
                bottomModal: () {
                  Navigator.of(context).pop();
                },
              ),
              Customizedbutton(
                label: 'VIEW DEVICE',
                labelColor: Colors.white,
                buttonColor: Colors.transparent,
                bottomModal: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic deviceData = context.watch<DeviceProvider>().deviceData;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.1),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/greaterThan.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Device Connected",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          itemCount: (deviceData.length / 2).ceil(),
                          itemBuilder: (context, rowIndex) {
                            final firstIndex = rowIndex * 2;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DeviceCard(
                                    name: deviceData[firstIndex].Device_name,
                                    imageUrl:
                                        deviceData[firstIndex].images_url != ''
                                            ? deviceData[firstIndex].images_url
                                            : 'assets/images/AirCond.png',
                                    isActive: deviceData[firstIndex].is_active,
                                    id: deviceData[firstIndex].id,
                                    roomName: '',
                                  ),
                                  if (firstIndex + 1 < deviceData.length)
                                    DeviceCard(
                                      roomName: '',
                                      name:
                                          deviceData[firstIndex + 1]
                                              .Device_name,
                                      imageUrl:
                                          deviceData[firstIndex + 1]
                                                      .images_url !=
                                                  ''
                                              ? deviceData[firstIndex + 1]
                                                  .images_url
                                              : 'assets/images/AirCond.png',
                                      isActive:
                                          deviceData[firstIndex + 1].is_active,
                                      id: deviceData[firstIndex + 1].id,
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),

                  Spacer(),
                  Customizedbutton(
                    label: hasExistingData ? 'Edit Device' : 'Add Device',
                    labelColor: Colors.black,
                    buttonColor: Color(0xFFB9F249),
                    bottomModal: hasExistingData ? EditImageModal : bottomModal,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadingButton(Color buttonColor, Color labelColor, String label) {
    return InkWell(
      onTap: () {
        bottomModal();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  dynamic pickImageButton(
    ImageSource imageSource,
    String label,
    StateSetter setModalState,
  ) {
    return !showUploadingButtonImage
        ? Customizedbutton(
          label: label,
          labelColor: Colors.black,
          buttonColor: Color(0xFFB9F249),
          bottomModal: () async {
            _imageFile = await cloud.pickImage(imageSource);
            setModalState(() {
              showUploadingButtonImage = !showUploadingButtonImage;
            });
          },
        )
        : SizedBox.shrink();
  }

  void _resetFormData() {
    setState(() {
      name = '';
      room_id = 0;
      livRoom = false;
      images_url = '';
      showUploadingButtonImage = false;
      isUploadingImage = false;
      isCreatingDevice = false;
      currentDevice = [];
    });
  }
}

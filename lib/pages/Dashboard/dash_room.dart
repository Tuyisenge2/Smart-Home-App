import 'package:flutter/material.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/rooms_component.dart';
import 'package:new_app/models/fetch_rooms_response.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/services/create_service.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'package:new_app/components/times_button.dart';
import 'package:new_app/util/cloudinary_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashRoom extends StatefulWidget {
  DashRoom({super.key});

  @override
  DashRoomState createState() => DashRoomState();
}

class DashRoomState extends State<DashRoom> {
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
                      "Room Image",
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

                              // hasExistingData
                              //     ? await _updateDevice(
                              //       null,
                              //       null,
                              //       null,
                              //       currentDevice[0]['imageUrl'],
                              //       images_url,
                              //     )
                              //     : await _addDevice('', 0, images_url);

                              setModalState(() {
                                showUploadingButtonImage =
                                    !showUploadingButtonImage;
                                isUploadingImage = false;
                                _imageFile = null;
                              });
                              Navigator.of(context).pop();
                              //Future.delayed(Duration(milliseconds: 300), () {
                              createSceneThirdModal();
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
                          "Room Name",
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

                                  // await _updateDevice(
                                  //   null,
                                  //   value,
                                  //   null,
                                  //   images_url,
                                  //   null,
                                  // );
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
                  Customizedbutton(
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

                        final response = await createRoom(
                          name,
                          images_url,
                          token!,
                        );
                        if (response['status'] == true) {
                          setState(() {
                            isCreatingDevice = false;
                          });
                          showTopSnackBar(
                            context,
                            'Room created successful!',
                            Colors.green,
                          );
                          //  _deleteDevice(images_url);
                          //  hasExistingData = false;
                          //    _resetFormData();
                          Navigator.of(context).pop();
                          //  getDevicesData();
                          getRoomData();
                          //  createSceneFoufthModal(name);
                        }
                      } catch (e) {
                        print('Error creating room: $e');
                        showTopSnackBar(
                          context,
                          'Room creation Failed!',
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

  @override
  Widget build(BuildContext context) {
    dynamic roomData = context.watch<RoomsProvider>().roomData;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(
              'Your Room\'s',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.001,
              ),
              child: Column(
                spacing: MediaQuery.of(context).size.height * 0.02,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      itemCount: (roomData.length / 2).ceil(),
                      itemBuilder: (context, rowIndex) {
                        final firstIndex = rowIndex * 2;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RoomsComponent(
                                    roomName: roomData[firstIndex].name,
                                    deviceCount:
                                        roomData[firstIndex].devices.length ??
                                        0,
                                    isRoomorHome: 'Room',
                                    devices: roomData[firstIndex].devices,
                                    id: roomData[firstIndex].id,
                                    image_path: roomData[rowIndex].image_path,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Expanded(
                                  child:
                                      firstIndex + 1 < roomData.length
                                          ? RoomsComponent(
                                            roomName:
                                                roomData[firstIndex + 1].name,
                                            deviceCount:
                                                roomData[firstIndex + 1]
                                                    .devices
                                                    .length ??
                                                0,
                                            isRoomorHome: 'Room',
                                            devices:
                                                roomData[firstIndex + 1]
                                                    .devices,
                                            id: roomData[firstIndex + 1].id,
                                            image_path:
                                                roomData[rowIndex].image_path,
                                          )
                                          : Container(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.02,
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Customizedbutton(
              label: "Create Room",
              labelColor: Colors.black,
              buttonColor: Color(0xFFB9F249),
              bottomModal: bottomModal,
            ),
          ),
        ],
      ),
    );
  }
}

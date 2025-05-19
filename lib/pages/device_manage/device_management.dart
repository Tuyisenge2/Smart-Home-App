// ignore_for_file: non_constant_identifier_names, camel_case_types, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/device_card.dart';
import 'package:new_app/components/times_button.dart';
import 'package:new_app/models/fetch_device_response.dart';
import 'package:new_app/provider/device_provider.dart';
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
  bool uploadImage = false;
  bool isUploadingImage = false;
  bool isCreatingDevice = false;
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

  Container circleDays(String l) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          l,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Container deviceTextCont(String l) {
    return Container(
      height: 25,
      width: 135,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          l,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
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
                      "Light",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    //
                    child: SvgPicture.asset('assets/icons/sun.svg'),
                  ),

                  !uploadImage
                      ? Customizedbutton(
                        label: 'Select from Gallery',
                        labelColor: Colors.black,
                        buttonColor: Color(0xFFB9F249),
                        bottomModal: () async {
                          _imageFile = await cloud.pickImage(
                            ImageSource.gallery,
                          );
                          setModalState(() {
                            uploadImage = !uploadImage;
                          });
                        },
                      )
                      : isUploadingImage
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
                          setModalState(() {
                            uploadImage = !uploadImage;
                            isUploadingImage = false;
                          });
                          Navigator.of(context).pop();
                          //Future.delayed(Duration(milliseconds: 300), () {
                          creatSceneSecondModal();
                          //});
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

  void creatSceneSecondModal() {
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
              height: MediaQuery.of(context).size.height * 0.8,
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
                  InkWell(
                    onTap: () {
                      setModalState(() {
                        livRoom = !livRoom;
                        room_id = 1;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 190,
                      decoration: BoxDecoration(
                        color: livRoom ? Color(0xFFB9F249) : Color(0xFF181D23),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Living Room',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D23),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        'Living Room',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D23),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        'Bed Room',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D23),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        'Kitchen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
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
                          "Light Name",
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
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                decoration: InputDecoration(
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
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  "×",
                                  style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  !isCreatingDevice
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
                              Navigator.of(context).pop();
                              getDevicesData();

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
                    "\"Masterbed\" ",
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
    print(
      '44444444444444444444444444444444444444444444444444444444 4ouivbjintwreewpqqqqqqqqqqqqqqqqqppppppppppppppqwssssssssssssssssssssssssssssssss $deviceData ',
    );
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
                        height: MediaQuery.of(context).size.height * 0.45,
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
                                  ),
                                  if (firstIndex + 1 < deviceData.length)
                                    DeviceCard(
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
                    label: 'Add Device',
                    labelColor: Colors.black,
                    buttonColor: Color(0xFFB9F249),
                    bottomModal: bottomModal,
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
}

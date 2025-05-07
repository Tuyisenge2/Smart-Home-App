// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/input_field.dart';
import 'package:new_app/components/scene_card.dart';
import 'package:new_app/components/times_button.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/provider/is_user_auth_provider.dart';
import 'package:new_app/provider/rooms_provider.dart';
import 'package:new_app/provider/scene_provider.dart';
import 'package:new_app/services/create_service.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:new_app/util/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateScene extends StatefulWidget {
  @override
  _CreateScene createState() => _CreateScene();
}

class _CreateScene extends State<CreateScene> {
  dynamic backendRes;
  String name = '';
  List daysOfWeek = [];
  List<int> selectedDeviceIds = [];
  String startTime = '';
  String endTime = '';
  bool sendNofication = false;
  //  bool? isActive;
  List? devices;

  String startHour = '12';
  String startMinute = '00';
  String startPeriod = 'AM';
  String endHour = '12';
  String endMinute = '00';
  String endPeriod = 'AM';

  List<String> hours = List.generate(
    12,
    (index) => (index + 1).toString().padLeft(2, '0'),
  );
  List<String> minutes = ['00', '15', '30', '45'];
  List<String> periods = ['AM', 'PM'];
  String getStartTime() => '$startHour:$startMinute $startPeriod';
  String getEndTime() => '$endHour:$endMinute $endPeriod';
  bool _isCreatingScene = false;
  @override
  void initState() {
    super.initState();
    getSceneData();
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
      print('Error fetching scene data:  $e');
      throw Exception('Error fetching scene data');
    }
  }

  Utils utils = Utils();

  Widget circleDays(String dayAbbreviation, StateSetter setModalState) {
    final dayMap = {
      'M': 'Monday',
      'T': 'Tuesday',
      'W': 'Wednesday',
      'Th': 'Thursday',
      'F': 'Friday',
      'S': 'Saturday',
      'Su': 'Sunday',
    };
    final isSelected = daysOfWeek.contains(
      dayMap[dayAbbreviation] ?? dayAbbreviation,
    );

    return InkWell(
      onTap: () {
        setModalState(() {
          final dayName = dayMap[dayAbbreviation] ?? dayAbbreviation;
          if (isSelected) {
            daysOfWeek.remove(dayName);
          } else {
            daysOfWeek.add(dayName);
          }
        });
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Color(0xFFB9F249) // Selected color
                  : Colors.white.withOpacity(.2), // Unselected color
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            dayAbbreviation,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  Widget deviceTextCont(String l, int deviceId, bool isSelected) {
    return InkWell(
      child: Container(
        height: 25,
        width: 135,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Color(0xFFB9F249).withOpacity(0.8)
                  : Colors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            l,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(
                  context,
                ).viewInsets.bottom, // Adjusts for keyboard
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Name Scene",
                      style: TextStyle(
                        color: Color(0xFFB9F249),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Color(0xFFB9F249)),
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
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
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
                    label: 'Back',
                    labelColor: Color(0xFFB9F249),
                    buttonColor: Color(0xFF31373C),
                    bottomModal: () {
                      Navigator.of(context).pop();
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

  void creatSceneSecondModal() {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.006,
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
                      "Schedule",
                      style: TextStyle(
                        color: Color(0xFFB9F249),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D23),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.repeat,
                                color: Color(0xFFB9F249),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              " Repeats Every",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: MediaQuery.of(context).size.width * 0.03,
                          children: [
                            circleDays('M', setModalState),
                            circleDays('T', setModalState),
                            circleDays('W', setModalState),
                            circleDays('Th', setModalState),
                            circleDays('F', setModalState),
                            circleDays('S', setModalState),
                            circleDays('Su', setModalState),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D23),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/notifications.svg',
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Text(
                            "get notified on your phone when this routine starts ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              setModalState(
                                () => sendNofication = !sendNofication,
                              );
                            },
                            child:
                                sendNofication
                                    ? SvgPicture.asset(
                                      'assets/icons/toggleButtonOn.svg',
                                    )
                                    : SvgPicture.asset(
                                      'assets/icons/toggleButton.svg',
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                    ),
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D23),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Start Time',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                            ),

                            Text(
                              'End Time',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            // Start Hour Dropdown
                            _buildTimeDropdown(
                              value: startHour,
                              items: hours,
                              textColor: Color(0xFFB9F249),
                              onChanged:
                                  (value) =>
                                      setModalState(() => startHour = value!),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              ':',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFB9F249),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            // Start Minute Dropdown
                            _buildTimeDropdown(
                              value: startMinute,
                              items: minutes,
                              textColor: Color(0xFFB9F249),
                              onChanged:
                                  (value) =>
                                      setModalState(() => startMinute = value!),
                            ),
                            SizedBox(width: 1),
                            // Start Period Dropdown
                            _buildTimeDropdown(
                              value: startPeriod,
                              items: periods,
                              onChanged:
                                  (value) =>
                                      setModalState(() => startPeriod = value!),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                            ),
                            Text(
                              'To',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            // End Hour Dropdown
                            _buildTimeDropdown(
                              value: endHour,
                              items: hours,
                              textColor: Color(0xFFB9F249),
                              onChanged:
                                  (value) =>
                                      setModalState(() => endHour = value!),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              ':',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFB9F249),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            // End Minute Dropdown
                            _buildTimeDropdown(
                              value: endMinute,
                              items: minutes,
                              textColor: Color(0xFFB9F249),
                              onChanged:
                                  (value) =>
                                      setModalState(() => endMinute = value!),
                            ),
                            SizedBox(width: 1),
                            // End Period Dropdown
                            _buildTimeDropdown(
                              value: endPeriod,
                              items: periods,
                              onChanged:
                                  (value) =>
                                      setModalState(() => endPeriod = value!),
                            ),
                          ],
                        ),
                      ],
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
                  Customizedbutton(
                    label: 'Back',
                    labelColor: Color(0xFFB9F249),
                    buttonColor: Color(0xFF31373C),
                    bottomModal: () {
                      Navigator.of(context).pop();
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

  Container roomCard(String L, List<dynamic> devicesData) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.045,
        right: MediaQuery.of(context).size.width * 0.045,
      ),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF181D23),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            L,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () => _dialogBuilder(context, devicesData),
            child: SvgPicture.asset(
              "assets/icons/less2.svg",
              height: 16,
              width: 16,
            ),
          ),
        ],
      ),
    );
  }

  void createSceneThirdModal() {
    dynamic roomData = context.read<RoomsProvider>().roomData;
        showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              height: MediaQuery.of(context).size.height,
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
                      "Schedule",
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
                        return roomCard(
                          roomData[rowIndex].name,
                          roomData[rowIndex].devices,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  if (_isCreatingScene)
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFB9F249),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 10),
                            CircularProgressIndicator(color: Colors.white),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    Customizedbutton(
                      label: 'Continue',
                      labelColor: Colors.black,
                      buttonColor: Color(0xFFB9F249),
                      bottomModal: () async {
                        try {
                          setModalState(() => _isCreatingScene = true);

                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          String? token = pref.getString('token');
                          dynamic response = await createScene(
                            name,
                            daysOfWeek,
                            convertTo24HourFormat(getStartTime()),
                            convertTo24HourFormat(getEndTime()),
                            sendNofication,
                            token!,
                            selectedDeviceIds,
                          );
                          if (response['status'] == true) {
                            showTopSnackBar(
                              context,
                              'Scene created successful!',
                              Colors.green,
                            );
                            await utils.getSceneData(context);
                          }
                          Navigator.of(context).pop();
                          createSceneFoufthModal();
                        } catch (e) {
                          throw Exception('Failed to create scene');
                        }
                      },
                    ),
                  ],
                  Customizedbutton(
                    label: 'Back',
                    labelColor: Color(0xFFB9F249),
                    buttonColor: Color(0xFF31373C),
                    bottomModal: () {
                      Navigator.of(context).pop();
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

  void createSceneFoufthModal() {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
          ),
          height: MediaQuery.of(context).size.height * 0.4,
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
                    "New Scene Added",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    "\"Good Night\" ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              Customizedbutton(
                label: 'Done',
                labelColor: Colors.black,
                buttonColor: Color(0xFFB9F249),
                bottomModal: () {
                  _resetFormData();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context, List<dynamic> devices) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF31373C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Select device to turn",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    devices.length == 0
                        ? Text(
                          'No device exist here',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                        : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (devices.length / 2).ceil(),
                            itemBuilder: (context, index) {
                              final firstIndex = index * 2;
                              final secondIndex = firstIndex + 1;
                              final firstDevice =
                                  firstIndex < devices.length
                                      ? devices[firstIndex]
                                      : null;
                              final secondDevice =
                                  secondIndex < devices.length
                                      ? devices[secondIndex]
                                      : null;

                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (firstDevice != null)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (selectedDeviceIds.contains(
                                              firstDevice['id'],
                                            )) {
                                              selectedDeviceIds.remove(
                                                firstDevice['id'],
                                              );
                                            } else {
                                              selectedDeviceIds.add(
                                                firstDevice['id'],
                                              );
                                            }
                                          });
                                        },
                                        child: deviceTextCont(
                                          firstDevice['name'],
                                          firstDevice['id'],
                                          selectedDeviceIds.contains(
                                            firstDevice['id'],
                                          ),
                                        ),
                                      ),
                                    if (secondDevice != null)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (selectedDeviceIds.contains(
                                              secondDevice['id'],
                                            )) {
                                              selectedDeviceIds.remove(
                                                secondDevice['id'],
                                              );
                                            } else {
                                              selectedDeviceIds.add(
                                                secondDevice['id'],
                                              );
                                            }
                                          });
                                        },
                                        child: deviceTextCont(
                                          secondDevice['name'],
                                          secondDevice['id'],
                                          selectedDeviceIds.contains(
                                            secondDevice['id'],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic sceneData = context.watch<SceneProvider>().sceneData;

    bool isLoading =
        Provider.of<SceneProvider>(context, listen: false).isLoading;
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white.withOpacity(.1),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFB9F249)),
        ),
      );
    }
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
                      "Scene",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
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
                            : ListView.builder(
                              itemCount: sceneData.length,
                              itemBuilder: (context, index) {
                                final currentScene = sceneData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: SceneCard(
                                    sceneMess: currentScene.name,
                                    iconPath:
                                        currentScene.name
                                                .toLowerCase()
                                                .contains('morning')
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
                  Spacer(),
                  Customizedbutton(
                    label: 'Create yourScene',
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

  Widget _buildTimeDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    Color textColor = Colors.white,
  }) {
    return DropdownButton<String>(
      value: value,
      underline: Container(), // Remove default underline
      dropdownColor: Color(0xFF181D23),
      icon: SvgPicture.asset('assets/icons/dropDown.svg', height: 7, width: 7),
      style: TextStyle(fontSize: 15, color: textColor),
      onChanged: onChanged,
      items:
          items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
    );
  }

  String convertTo24HourFormat(String time12Hour) {
    try {
      final parts = time12Hour.split(' ');
      final timePart = parts[0];
      final period = parts[1].toUpperCase();

      final timeComponents = timePart.split(':');
      var hour = int.parse(timeComponents[0]);
      final minute = timeComponents[1];

      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return '${hour.toString().padLeft(2, '0')}:$minute';
    } catch (e) {
      print('Error converting time format: $e');
      return time12Hour; // fallback
    }
  }

  void _resetFormData() {
    setState(() {
      name = '';
      daysOfWeek = [];
      startHour = '12';
      startMinute = '00';
      startPeriod = 'AM';
      endHour = '12';
      endMinute = '00';
      endPeriod = 'AM';
      sendNofication = false;
      devices = null;
      selectedDeviceIds = [];
    });
  }
}

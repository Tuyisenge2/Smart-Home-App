import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/input_field.dart';
import 'package:new_app/components/scene_card.dart';
import 'package:new_app/components/times_button.dart';
import 'package:new_app/models/fetch_scene_response.dart';
import 'package:new_app/provider/is_user_auth_provider.dart';
import 'package:new_app/provider/scene_provider.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateScene extends StatefulWidget {
  @override
  _CreateScene createState() => _CreateScene();
}

class _CreateScene extends State<CreateScene> {
  dynamic backendRes;

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
        // print(
        //   'weoknion ngajrnine nab vikiiiiiiiiiiiiiiiiiiiiionerficrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrerf ${response}',
        // );
        context.read<SceneProvider>().setSceneData(response.scenes);
      }
    } catch (e) {
      print('Error fetching scene data: mana $e');
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
        return Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
          ),
          height: MediaQuery.of(context).size.height * 0.65,
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
                          child: Icon(Icons.repeat, color: Color(0xFFB9F249)),
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
                        circleDays('M'),
                        circleDays('T'),
                        circleDays('W'),
                        circleDays('T'),
                        circleDays('F'),
                        circleDays('S'),
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
                      child: SvgPicture.asset('assets/icons/toggleButton.svg'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                ),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF181D23),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'End Time',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'From',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Text(
                          '12.00',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFB9F249),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'AM',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        SvgPicture.asset(
                          'assets/icons/dropDown.svg',
                          height: 7,
                          width: 7,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                        ),
                        Text(
                          'To',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                        ),
                        Text(
                          '12.00',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFB9F249),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'AM',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        SvgPicture.asset(
                          'assets/icons/dropDown.svg',
                          height: 7,
                          width: 7,
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
  }

  Container roomCard(String L) {
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
            onTap: () => _dialogBuilder(context),
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
              roomCard('Living Room'),
              roomCard('BedRoom'),
              roomCard('BedRoom2'),
              roomCard('Kitchen'),
              Customizedbutton(
                label: 'Continue',
                labelColor: Colors.black,
                buttonColor: Color(0xFFB9F249),
                bottomModal: () {
                  Navigator.of(context).pop();
                  createSceneFoufthModal();
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.943333;
    final leftPosition = (screenWidth - dialogWidth) / 2;
    return showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: leftPosition,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.943333,
                    child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      insetPadding: EdgeInsets.zero,
                      titlePadding: EdgeInsets.zero,
                      actionsPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select device to turn ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  deviceTextCont('Air Conditioner'),
                                  deviceTextCont('Smart Led'),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  deviceTextCont('Air Conditioner'),
                                  deviceTextCont('Smart Led'),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  deviceTextCont('Air Conditioner'),
                                  deviceTextCont('Smart Led'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                    child: ListView.builder(
                      itemCount: sceneData.length,
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
}

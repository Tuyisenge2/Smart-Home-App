import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/device_card3.dart';
import 'package:new_app/components/input_field.dart';
import 'package:new_app/components/scene_card.dart';
import 'package:new_app/components/times_button.dart';

class deviceManagement extends StatefulWidget {
  @override
  _deviceManagementState createState() => _deviceManagementState();
}

class _deviceManagementState extends State<deviceManagement> {
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

              Customizedbutton(
                label: 'Continue',
                labelColor: Colors.black,
                buttonColor: Color(0xFFB9F249),
                bottomModal: () {
                  Navigator.of(context).pop();
                  creatSceneSecondModal();
                },
              ),
            ],
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
      builder: (BuildContext context) {
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
                  Customizedbutton(
                    label: 'Continue',
                    labelColor: Colors.black,
                    buttonColor: Color(0xFFB9F249),
                    bottomModal: () {
                      Navigator.of(context).pop();
                      createSceneFoufthModal();
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

  void createSceneFoufthModal() {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xFF31373C),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height * 0.01,
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
                    "Light Added to",
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
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [DeviceCard3(), DeviceCard3()],
                    ),
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
}

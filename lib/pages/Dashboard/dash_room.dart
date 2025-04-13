import 'package:flutter/material.dart';
import 'package:new_app/components/customizedButton.dart';
import 'package:new_app/components/rooms_component.dart';

class DashRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    children: [
                      Flexible(
                        child: RoomsComponent(
                          roomName: 'Living Room',
                          deviceCount: 2,
                          isRoomorHome: 'Room',
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Flexible(
                        child: RoomsComponent(
                          roomName: 'Living Room',
                          deviceCount: 2,
                          isRoomorHome: 'Room',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: RoomsComponent(
                          roomName: 'Living Room',
                          deviceCount: 2,
                          isRoomorHome: 'Room',
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Flexible(
                        child: RoomsComponent(
                          roomName: 'Living Room',
                          deviceCount: 2,
                          isRoomorHome: 'Room',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: RoomsComponent(
                          roomName: 'Living Room',
                          deviceCount: 2,
                          isRoomorHome: 'Room',
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Flexible(
                        child: RoomsComponent(
                          roomName: 'Living Room',
                          deviceCount: 2,
                          isRoomorHome: 'Room',
                        ),
                      ),
                    ],
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
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/components/nav_bar.dart';
import 'package:new_app/pages/Dashboard/dash2.dart';
import 'package:new_app/pages/Dashboard/dash3.dart';
import 'package:new_app/pages/Dashboard/dash4.dart';

class DashboardWithBottom extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardWithBottom> {
  void init() {}
  int pageIndex = 0;
  final pages = [Dash2(), Dash3(), Dash4()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NavBar(),
        backgroundColor: Colors.white.withOpacity(0),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
      ),
      body: pages[pageIndex],
      backgroundColor: Colors.white.withOpacity(.1),
      bottomNavigationBar: bottomnavigation(context),
    );
  }

  SizedBox bottomnavigation(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: 0.85,
        heightFactor: 0.8,
        child: Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color:
                        pageIndex == 0 ? Colors.lightGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      pageIndex == 0
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.dashboard, color: Colors.black),
                              SizedBox(width: 10),
                              Text(
                                'Home',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ],
                          )
                          : Icon(Icons.dashboard, color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color:
                        pageIndex == 1 ? Colors.lightGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      pageIndex == 1
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Group.svg',
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Rooms',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ],
                          )
                          : SvgPicture.asset(
                            'assets/icons/Group.svg',
                            color: Colors.white,
                          ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 15,
                    right: 15,
                  ),
                  decoration: BoxDecoration(
                    color:
                        pageIndex == 2 ? Colors.lightGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      pageIndex == 2
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/user2.svg',
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Menu',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ],
                          )
                          : SvgPicture.asset(
                            'assets/icons/user2.svg',
                            color: Colors.white,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

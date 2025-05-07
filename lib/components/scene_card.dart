// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_app/services/fetchDevice.dart';
import 'package:new_app/services/fetch_service.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SceneCard extends StatefulWidget {
  final String sceneMess;
  final String iconPath;
  final String togglePath;
  final bool isActive;
  final int id;
  const SceneCard({
    super.key,
    required this.sceneMess,
    required this.iconPath,
    required this.togglePath,
    required this.isActive,
    required this.id,
  });

  @override
  _SceneCardState createState() => _SceneCardState();
}

class _SceneCardState extends State<SceneCard> {
  bool isToggleOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.655),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: 35,
              width: 35,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(400),
              ),
              // child: SvgPicture.asset('assets/icons/sun.svg'),
              child: SvgPicture.asset(widget.iconPath),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              widget.sceneMess,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                try {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  String? token = pref.getString('token');
                  dynamic res = await updateScenes(
                    token!,
                    !widget.isActive,
                    widget.id,
                  );
                  await deviceUtils.getSceneData(context);
                  showTopSnackBar(
                    context,
                    'Scene updated successful!',
                    Colors.green,
                  );
                  await deviceUtils.getDevicesData(context);
                } catch (e) {
                  print('Error updating device: $e');
                  throw Exception('Error updating device');
                }
              },
              icon:
                  widget.isActive
                      ? SvgPicture.asset('assets/icons/toggleButtonOn.svg')
                      : SvgPicture.asset(widget.togglePath),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SceneCard extends StatefulWidget {
  final String sceneMess;
  final String iconPath;
  final String togglePath;
  const SceneCard({
    required this.sceneMess,
    required this.iconPath,
    required this.togglePath,
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
              onPressed: () {
                setState(() {
                  isToggleOn = !isToggleOn;
                });
              },
              icon:
                  isToggleOn
                      ? SvgPicture.asset('assets/icons/toggleButtonOn.svg')
                      : SvgPicture.asset(widget.togglePath),
            ),
          ),
        ],
      ),
    );
  }
}



// class SceneCard extends StatelessWidget {
  
//   final String sceneMess;
//   final String iconPath;
//   final String togglePath;
//   const SceneCard({
//     required this.sceneMess,
//     required this.iconPath,
//     required this.togglePath,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.655),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Flexible(
//             flex: 1,
//             child: Container(
//               height: 35,
//               width: 35,
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(400),
//               ),
//               // child: SvgPicture.asset('assets/icons/sun.svg'),
//               child: SvgPicture.asset(iconPath),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               sceneMess,
//               style: TextStyle(color: Colors.white, fontSize: 17),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: IconButton(
//               onPressed: () {},
//               icon: SvgPicture.asset(togglePath),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

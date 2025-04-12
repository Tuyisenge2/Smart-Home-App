import 'package:flutter/material.dart';
import 'package:new_app/components/responsive_text.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  context.push('/profile');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1240),
                  child: Image.asset(
                    'assets/images/heroBg2.jpg',
                    fit: BoxFit.cover,
                    height: 43,
                    width: 43,
                  ),
                ),
                //    ),
              ),
            ),
            ResponsiveText(
              textColor: Colors.white,
              fontSize: 24,
              text: "Sarah",
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  print("hey");
                },
                child: Container(
                  height: 39,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(400),
                  ),

                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: 6,
                        child: Icon(
                          size: 27,
                          Icons.notifications_none,
                          color: Colors.green,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

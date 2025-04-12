import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/components/responsive_text.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 124, left: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/heroBg2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ResponsiveText(
                textColor: Colors.white,
                fontSize: 48,
                text: "FULL CONTROL",
                fontweight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ResponsiveText(
                textColor: Colors.white,
                fontSize: 48,
                text: "FOR YOUR",
                fontweight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ResponsiveText(
                textColor: Colors.white,
                fontSize: 48,
                text: 'SMART',
                fontweight: FontWeight.w700,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ResponsiveText(
                textColor: Colors.white,
                fontSize: 48,
                text: 'HOUSES',
                fontweight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Flexible(
              fit: FlexFit.loose,
              child: TextButton(
                onPressed: () {
                  context.push('/login');
                },
                child: Center(
                  child: Container(
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: SvgPicture.asset('assets/icons/pd.svg'),
                        ),

                        ResponsiveText(
                          textColor: Colors.white,
                          fontSize: 20,
                          text: 'Get Started',
                          fontweight: FontWeight.w700,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/G-2.svg'),
                            SvgPicture.asset('assets/icons/G-1.svg'),
                            SvgPicture.asset('assets/icons/G.svg'),
                          ],
                        ),
                      ],
                    ),
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

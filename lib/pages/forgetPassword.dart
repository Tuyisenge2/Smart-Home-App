import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:new_app/components/back_button.dart';
import 'package:new_app/components/input_field.dart';
import 'package:new_app/components/responsive_text.dart';

class Forgetpassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, top: 65, right: 25),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/greenPlant.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BackButtonComponent(route: "/login"),

              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 45,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      child: SvgPicture.asset('assets/icons/wifi.svg'),
                    ),
                  ),
                  SizedBox(width: 14),

                  ResponsiveText(
                    text: 'HOMESYNC',
                    textColor: Colors.white,
                    fontSize: 40,
                    fontweight: FontWeight.w900,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "FORGET PASSWORD",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: Text(
                  "Looks like you have forgot your password. Let’s create new password for you. Enter your Email",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 20),

              InputField(width: 400, hint: 'Email', inputColor: Colors.white),
              SizedBox(height: 20),
              SizedBox(
                height: 47,
                width: 400,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: Text("SUBMIT", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

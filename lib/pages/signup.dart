import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:new_app/components/back_button.dart';
import 'package:new_app/components/forget_button.dart';
//import 'package:new_app/components/input_field.dart';
import 'package:new_app/components/responsive_text.dart';
import 'package:new_app/services/create_service.dart';
import 'package:new_app/util/snack_bar.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = '';
  String password = '';
  String name = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      //  padding: EdgeInsets.only(left: 25, top: 65, right: 25),
      width: double.infinity,
      height: double.infinity,
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
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: SingleChildScrollView(
              child: SizedBox(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                            child: SvgPicture.asset('assets/icons/wifi.svg'),
                          ),
                        ),
                        SizedBox(width: 14),

                        ResponsiveText(
                          text: 'HOMESYNC',
                          textColor: Colors.white,
                          fontSize: 30,
                          fontweight: FontWeight.w900,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Looks like you don't have an account. Let’s create an account for you.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),

                    InputField(400, 'Name', Colors.white, 'name'),
                    SizedBox(height: 10),

                    InputField(400, 'Email', Colors.white, 'email'),
                    SizedBox(height: 10),

                    InputField(400, 'Password', Colors.white, 'password'),
                    SizedBox(height: 10),

                    InputField(
                      400,
                      ' Confirm_Password',
                      Colors.white,
                      'confirmPassword',
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 47,
                      width: 400,
                      child: TextButton(
                        onPressed: () async {
                          try {
                            final response = await signupUser(
                              email,
                              password,
                              confirmPassword,
                              name,
                            );
                            if (response['status'] == true) {
                              showTopSnackBar(
                                context,
                                'Registration successful!',
                                Colors.green,
                              );
                              context.push('/Login');
                            }
                          } catch (e) {
                            print('Error signing up: $e');
                            showTopSnackBar(
                              context,
                              'Registration Failed!',
                              Colors.red,
                            );
                          }                          
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 47,
                      width: 400,
                      child: TextButton(
                        onPressed: () => context.push("/login"),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    SizedBox(width: 400, child: ForgetButton()),
                    SizedBox(height: 20),

                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      height: 47,
                      width: 400,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                              child: SvgPicture.asset(
                                'assets/icons/google-icon.svg',
                              ),
                            ),

                            ResponsiveText(
                              text: "SIGN UP WITH GOOGLE",
                              textColor: Colors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ConstrainedBox InputField(
    double width,
    String hint,
    Color inputColor,
    String input,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: TextField(
        onChanged: (value) {
          setState(() {
            if (input == 'email') {
              email = value;
            } else if (input == 'password') {
              password = value;
            } else if (input == 'confirmPassword') {
              confirmPassword = value;
            } else if (input == 'name') {
              name = value;
            }
          });
        },
        decoration: InputDecoration(
          hintText: hint,
          fillColor: inputColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: inputColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}

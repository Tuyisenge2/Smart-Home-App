import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:new_app/components/back_button.dart';
import 'package:new_app/components/forget_button.dart';
//import 'package:new_app/components/input_field.dart';
import 'package:new_app/components/responsive_text.dart';
import 'package:new_app/models/user_login_response.dart';
import 'package:new_app/provider/is_user_auth_provider.dart';
import 'package:new_app/services/auth_service.dart';
//import 'package:new_app/provider/user_provider.dart';
import 'package:new_app/services/login_service.dart';
import 'package:new_app/services/prefs.dart';
import 'package:new_app/util/snack_bar.dart';
import 'package:new_app/util/validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => loginScreen();
}

class loginScreen extends State<Login> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  String email = '';
  String password = '';
  Future<UserLoginResponse>? futureLogin;
  bool _emailValidate = false;
  bool _passwordValidate = false;
  String? _emailErrorMessage; // Separate error for email
  String? _passwordErrorMessage;
  @override
  Widget build(BuildContext context) {
    //  var userName=context.watch<UserProvider>().userName;
    //  String userName =Provider.of<UserProvider>(context, listen: false).userName;
    // String token = Provider.of<IsUserAuthProvider>(context).token;
    bool isLoading = Provider.of<AuthService>(context).isLoading;
    return Container(
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
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackButtonComponent(route: "/"),
                    SizedBox(height: 10),
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
                      "SIGN IN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 10),
                    Text(
                      "Looks like you have an account. Let’s sign in into your account for you.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    InputField(
                      400,
                      'Email',
                      Colors.white,
                      'email',
                      false,
                      _emailValidate,
                      _emailErrorMessage ?? 'Enter a valid email address',
                    ),
                    SizedBox(height: 10),
                    InputField(
                      400,
                      'Password',
                      Colors.white,
                      'password',
                      true,
                      _passwordValidate,
                      _passwordErrorMessage ?? 'Enter a valid password',
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      height: 47,
                      width: 400,
                      child: TextButton(
                        onPressed:
                            isLoading
                                ? null
                                : () async {
                                  try {
                                    context.read<AuthService>().setIsLoading(
                                      true,
                                    );
                                    setState(() {
                                      // Reset validation states
                                      _emailValidate = false;
                                      _passwordValidate = false;
                                      _emailErrorMessage =
                                          null; // Set email error
                                      _passwordErrorMessage = null;
                                    });
                                    final emailError = Validators.validateEmail(
                                      email,
                                    );
                                    final passwordError =
                                        Validators.validatePassword(password);

                                    if (emailError != null ||
                                        passwordError != null) {
                                      setState(() {
                                        _emailValidate = emailError != null;
                                        _passwordValidate =
                                            passwordError != null;
                                        _emailErrorMessage = emailError;
                                        _passwordErrorMessage = passwordError;
                                      });
                                      return;
                                    }

                                    final response = await loginUser(
                                      email,
                                      password,
                                    );
                                    if (response.access_token.isNotEmpty) {
                                      print(
                                        'LLLLLLLLLLLLLLLLLLLLLLLLLLLLLGGGGGGOOOOOOOOOOOOOOOOOOOOOOOOOOOOOIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII ${response.user}',
                                      );

                                      final userMap =
                                          response.user as Map<String, dynamic>;
                                      final isActive =
                                          userMap['is_active'] as int? ?? 0;
                                      final userEmail =
                                          userMap['name'] as String? ?? '';

                                      if (isActive != 1) {
                                       
                                        showTopSnackBar(
                                          context,
                                          '  This account has been deactivated, contact for support',
                                          Colors.red,
                                        );
                                        return;
                                      }                                                                  
                                      await context
                                          .read<AuthService>()
                                          .saveToken(response.access_token);

                                      context.read<AuthService>().setname(
                                        userEmail,
                                      );

                                      upDatePrefs(
                                        'token',
                                        response.access_token,
                                      );

                                      if (mounted) {
                                        context.push('/dashboard');
                                      }
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Login failed - no token received',
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    // Handle errors
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Login error: ${e.toString()}',
                                        ),
                                      ),
                                    );
                                  } finally {
                                    // Ensure loading is set to false when done
                                    context.read<AuthService>().setIsLoading(
                                      false,
                                    );
                                  }
                                },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child:
                            isLoading
                                ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ],
                                )
                                : Text(
                                  "LOGIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 47,
                      width: 400,
                      child: TextButton(
                        onPressed: () {
                          context.push('/signup');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: Text(
                          "SIGN UP",
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
    bool isPassword,
    bool _validate,
    String _errorMessage,
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
            }
          });
        },
        obscureText: isPassword,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: hint,
          fillColor: inputColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: inputColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorText: _validate ? _errorMessage : null,
        ),
      ),
    );
  }
}

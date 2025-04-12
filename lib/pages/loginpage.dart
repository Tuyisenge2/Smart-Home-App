import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" ")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type your username",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/user-1.svg'),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 25),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type your password",
            //      disabledBorder: InputBorder(bordernSide(BorderSide.none)),
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/user-1.svg'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 350,
            height: 30,
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              "forgot password?",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(350, 40),
              backgroundColor: Colors.pinkAccent,
            ),
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 60),
          Text(
            "Or Sign Up Using",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              SvgPicture.asset('assets/icons/user-1.svg'),
              SvgPicture.asset('assets/icons/user-1.svg'),
              SvgPicture.asset('assets/icons/user-1.svg'),
            ],
          ),
          SizedBox(height: 130),
          Text(
            "Or Sign Up Using",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            "SIGN UP",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

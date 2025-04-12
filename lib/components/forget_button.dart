import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetButton extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return     Center(
                child:
                TextButton(
                  onPressed: () => context.push('/forget'),
                  child: Text(
                    "FORGET PASSWORD?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              );
  }


} 
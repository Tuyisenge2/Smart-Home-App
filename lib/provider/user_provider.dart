
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
   final String _userName = "John Doe";
String get userName => _userName;

}
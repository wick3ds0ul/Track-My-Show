import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/homeScreen/home.dart';
import 'package:track_my_show/Screens/wrapper.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/Screens/registration/Registration_screen.dart';
import 'routenames.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Pass the arguments if needed
    // final args = settings.arguments;
    switch (settings.name) {
      case wrapper:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return null;
    }
  }
}

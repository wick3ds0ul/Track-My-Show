import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/homeScreen/home.dart';
//
import 'package:track_my_show/Screens/wrapper.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/Screens/Registration_screen.dart';
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
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        //Add 404 Image
        body: Center(
          child: Text('404.Page not found'),
        ),
      );
    });
  }
}

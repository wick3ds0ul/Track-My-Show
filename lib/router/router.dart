import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/details_screen.dart';
import 'package:track_my_show/Screens/forgot_password.dart';
import 'package:track_my_show/Screens/movieScreen/movieScreen.dart';
import 'package:track_my_show/Screens/wrapper.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/Screens/registration/Registration_screen.dart';
import 'routenames.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Pass the arguments if needed
    final args = settings.arguments;
    switch (settings.name) {
      case wrapper:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case movieScreen:
        return MaterialPageRoute(builder: (_) => MovieScreen());
      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case movieDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => DetailsScreen(
                  id: args,
                ));
      default:
        return null;
    }
  }
}

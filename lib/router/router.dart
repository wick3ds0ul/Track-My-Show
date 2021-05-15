import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/animeScreen/anime_screen.dart';
import 'package:track_my_show/Screens/listScreen/list.dart';
import 'package:track_my_show/Screens/movieScreen/movie_details_screen.dart';
import 'package:track_my_show/Screens/forgot_password.dart';
import 'package:track_my_show/Screens/movieScreen/movieScreen.dart';
import 'package:track_my_show/Screens/showScreen/show_details_screen.dart';
import 'package:track_my_show/Screens/showScreen/show_screen.dart';
import 'package:track_my_show/Screens/wrapper.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/Screens/registration/Registration_screen.dart';
import 'package:track_my_show/Screens/details_test.dart';
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
      case showScreen:
        return MaterialPageRoute(builder: (_) => ShowScreen());
      case animeScreen:
        return MaterialPageRoute(builder: (_) => AnimeScreen());
      case forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case movieDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(
                  args: args,
                ));
      case showDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => ShowDetailsScreen(
                  id: args,
                ));
      case listScreen:
        return MaterialPageRoute(builder: (_) => MyList());
      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/Screens/movieScreen/movieScreen.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<AppUser>(context);
    if (currentUser != null) {
      print(currentUser);
    } else {
      print("No user is logged in");
    }
    SizeConfig().init(context);
    return currentUser == null ? LoginScreen() : MovieScreen();
  }
}

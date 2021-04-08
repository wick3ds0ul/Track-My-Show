import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/Screens/homeScreen/home.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser>(context);
    if (currentUser != null) {
      print(currentUser.uid);
    } else {
      print("Current user is null");
    }
    SizeConfig().init(context);
    return currentUser == null ? LoginScreen() : HomeScreen();
  }
}

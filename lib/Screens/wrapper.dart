import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'package:track_my_show/utils/size_config.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return LoginScreen();
  }
}

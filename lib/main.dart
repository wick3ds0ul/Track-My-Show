import 'package:track_my_show/Screens/LoginScreen/login_screen.dart';
import 'utils/theme.dart';
import 'utils/size_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title;
  MyApp({this.title});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track My Show',
      theme: themeData,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // body: Center(
      //   child: Text('Track My Show'),
      // ),
      body: LoginScreen(),
    );
  }
}

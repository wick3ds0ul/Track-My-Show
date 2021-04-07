import 'file:///G:/Development/Projects/track_my_show/lib/router/routenames.dart';
import 'utils/theme.dart';
import 'package:flutter/material.dart';
import 'router/router.dart';

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
      initialRoute: wrapper,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

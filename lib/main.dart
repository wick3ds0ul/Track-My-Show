import 'package:track_my_show/router/errorRoute.dart';

import './router/routenames.dart';
import 'utils/theme.dart';
import 'package:flutter/material.dart';
import 'router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      // initialData: null,
      value: AuthService().user,

      ///
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Track My Show',
        theme: themeData,
        initialRoute: homeScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => ErrorRoute());
        },
      ),
    );
  }
}

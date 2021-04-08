import 'package:flutter/material.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await _auth.signOutNormal().then((_) {
                  print("Done");
                  Navigator.pushReplacementNamed(context, loginScreen);
                }).catchError((error) {
                  print(error);
                });
              },
              child: Text('Logout'))
        ],
      ),
      body: Center(
        child: Container(
          child: Text('Welcome Home Screen'),
        ),
      ),
      backgroundColor: Colors.redAccent,
    );
  }
}

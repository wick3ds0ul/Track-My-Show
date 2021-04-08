import 'package:flutter/material.dart';
import 'package:track_my_show/router/routenames.dart';

class ErrorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Add 404 Image
      body: Center(
        child: Column(
          children: [
            Text('404.Page not found. Return to Sign In Page'),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, loginScreen);
                },
                child: Text("Sign In"))
          ],
        ),
      ),
    );
  }
}

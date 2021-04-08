import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/widgets/exit_modal.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: SizedBox.shrink(),
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
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExitModlal();
            }
            // builder: (context) => new AlertDialog(
            //   title: new Text('Confirm Exit?',
            //       style: new TextStyle(
            //           color: Colors.black,
            //           fontSize: 20.0,
            //           fontFamily: 'Comfortaa')),
            //   content: new Text(
            //       'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.'),
            //   actions: <Widget>[
            //     new FlatButton(
            //       onPressed: () {
            //         // this line exits the app.
            //         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            //       },
            //       child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
            //     ),
            //     new FlatButton(
            //       onPressed: () =>
            //           Navigator.pop(context), // this line dismisses the dialog
            //       child: new Text('No', style: new TextStyle(fontSize: 18.0)),
            //     )
            //   ],
            // ),
            ) ??
        false;
  }
}

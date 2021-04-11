import 'package:flutter/material.dart';
import 'package:track_my_show/router/routenames.dart';

import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:track_my_show/widgets/common_widgets.dart';
import 'package:track_my_show/widgets/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final _emailController = TextEditingController();

  final AuthService _auth = AuthService();

  //SnackBar
  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'OKAY',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          TextEditingController().clear();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, bottom: 15, left: 15),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 5),
                                blurRadius: 7)
                          ]),
                    ),
                  ),
                  buildEmailTextFormField(_emailController),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                  ),
                  CustomButton(
                    name: 'Get Confirmation Email',
                    color: Colors.redAccent,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        FocusScope.of(context).unfocus();
                        try {
                          //Check if email already exist
                          List<String> res =
                              await _auth.checkEmail(_emailController.text);
                          print(res.toString());
                          if (res != null) {
                            await _auth.resetPassword(_emailController.text);
                            showInSnackBar(
                                'Email sent.Check your mail', context);
                          }
                        } catch (e) {
                          showInSnackBar(e, context);
                        }
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    alignment: Alignment.bottomLeft,
                    child: TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.7),
                            onSurface: Colors.grey,
                            primary: Colors.white),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.pushReplacementNamed(context, loginScreen);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Go Back',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'comfortaa',
                              fontSize: 15),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

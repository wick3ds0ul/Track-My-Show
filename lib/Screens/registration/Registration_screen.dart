import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'file:///G:/Development/Projects/track_my_show/lib/widgets/common_widgets.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _resetPasswordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    _resetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        new TextEditingController().clear();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 50, bottom: 15, left: 15),
                  child: Text('SignUp',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 5),
                                blurRadius: 7)
                          ]))),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    children: [
                      buildEmailTextFormField(_emailController),
                      buildPasswordTextFormField(_passwordController),
                      buildRePasswordTextFormField(_resetPasswordController),
                      Container(
                        height: 43,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                          onPressed: () async {
                            print(_emailController.text);
                            print(_passwordController.text);
                            if (_formKey.currentState.validate()) {
                              try {
                                dynamic res =
                                    await _auth.registerWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);
                                if (res != null) {
                                  Navigator.pushNamed(context, loginScreen);
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          child: Text("NEXT",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(fontSize: 13),
                                  fontWeight: FontWeight.bold)),
                        ),
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
                              Navigator.pushReplacementNamed(
                                  context, loginScreen);
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
            ],
          ),
        ),
      ),
    );
  }
}

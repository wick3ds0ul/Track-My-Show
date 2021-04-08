import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import './LoginScreen/form_validation.dart';

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

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Register'),
          ),
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
                    buildEmailTextFormField(),
                    buildPasswordTextFormField(),
                    Container(
                      height: 43,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmailTextFormField() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: TextFormField(
          controller: _emailController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(13, 13, 10, 13),
            hintText: 'Email',
            // hintStyle: TextStyle(fontSize: 13),
            hintStyle: GoogleFonts.roboto(fontSize: 13),
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2.0),
                borderRadius: BorderRadius.zero),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.zero,
            ),
          ),
          validator: validateEmail),
    );
  }

  Widget buildPasswordTextFormField() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: TextFormField(
          controller: _passwordController,
          cursorColor: Colors.black,
          obscureText: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(13, 13, 10, 13),
            hintText: 'Password',
            // hintStyle: TextStyle(fontSize: 13),
            hintStyle: GoogleFonts.roboto(fontSize: 13),
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2.0),
                borderRadius: BorderRadius.zero),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.zero,
            ),
          ),
          validator: validatePassword),
    );
  }
}

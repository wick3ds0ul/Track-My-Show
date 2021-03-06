import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/widgets/common_widgets.dart';
import '../LoginScreen/form_validation.dart';

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
  final _repasswordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
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
        // appBar: AppBar(),
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
                      buildRePasswordTextFormField(),
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
                                  showInSnackBar('You can now login', context);
                                  Navigator.pushNamed(context, loginScreen);
                                }
                              } catch (e) {
                                showInSnackBar(e.toString(), context);
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

  Widget buildEmailTextFormField() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: TextFormField(
          controller: _emailController,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(13, 13, 10, 13),
            hintText: 'example@email.com',
            hintStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
            labelText: 'Email',
            labelStyle: GoogleFonts.roboto(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colors.purpleAccent,
                  width: 2.0,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 2.0),
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
            hintText: "A-Ba-b1-9@#\$%^&*",
            hintStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
            labelText: 'Password',
            labelStyle: GoogleFonts.roboto(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password cannot be empty';
            } else if (value != _repasswordController.text) {
              return 'Password does not match';
            } else if (value.length < 6) {
              return 'Password must be greater than 6 character';
            } else
              return null;
          }),
    );
  }

  Widget buildRePasswordTextFormField() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: TextFormField(
          controller: _repasswordController,
          cursorColor: Colors.black,
          obscureText: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(13, 13, 10, 13),
            hintText: "A-Ba-b1-9@#\$%^&*",
            hintStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
            labelText: 'Re-Enter Password',
            labelStyle: GoogleFonts.roboto(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password cannot be empty';
            } else if (value != _passwordController.text) {
              return 'Password does not match';
            } else if (value.length < 6) {
              return 'Password must be greater than 6 character';
            } else
              return null;
          }),
    );
  }
}

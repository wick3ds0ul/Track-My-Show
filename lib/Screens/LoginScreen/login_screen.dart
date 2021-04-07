import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'file:///G:/Development/Projects/track_my_show/lib/utils/constants.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/widgets/custom_button.dart';
import 'form_validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(60),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/c1/65/1f/c1651f598d212acdfe551f103548e495.png'),
              ),
              SizedBox(
                height: getProportionateScreenHeight(60),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: kLabelStyle,
                        hintText: 'youremail@example.com',
                        hintStyle: kHintTextStyle,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.redAccent, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: kLabelStyle,
                        hintText: 'Your Password',
                        hintStyle: kHintTextStyle,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.redAccent, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                      validator: validatePassword,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    CustomButton(
                        name: 'Login',
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print("OK");
                          }
                        },
                        color: Colors.redAccent),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    Text('Don\'t have an account?'),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text(
                      'OR',
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Text('Login with'),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: IconButton(
                              iconSize: 50,
                              color: Colors.blue,
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                              icon: FaIcon(FontAwesomeIcons.facebook),
                              onPressed: () {
                                print("Pressed");
                              }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: IconButton(
                              iconSize: 50,
                              color: Colors.red,
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                              icon: FaIcon(FontAwesomeIcons.google),
                              onPressed: () {
                                print("Pressed");
                              }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: IconButton(
                              iconSize: 50,
                              color: Colors.green,
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                              icon: FaIcon(FontAwesomeIcons.spotify),
                              onPressed: () {
                                print("Pressed");
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

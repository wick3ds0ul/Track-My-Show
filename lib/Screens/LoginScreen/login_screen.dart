import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        labelStyle: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            // fontWeight: FontWeight.w200,
                            color: Colors.white),
                        hintText: 'youremail@example.com',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
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
                        labelStyle: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 18,
                            // fontWeight: FontWeight.w200,
                            color: Colors.white),
                        hintText: 'Your Password',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
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

//Form validation-Email
  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);

    //Check for empty string
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }
}

//Form validation-Email
String validatePassword(String value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < 6) {
    return 'Password must be greater than 6 character';
  } else
    return null;
}

class CustomButton extends StatelessWidget {
  final String name;
  final Function onPressed;
  final Color color;
  CustomButton({this.name, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: Container(
          child: MaterialButton(
            color: color,
            child: new Text(
              name,
            ),
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }
}

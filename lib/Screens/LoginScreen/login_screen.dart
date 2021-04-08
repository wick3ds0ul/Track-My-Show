import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import '../../utils/constants.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/widgets/custom_button.dart';
import 'form_validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        new TextEditingController().clear();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _formKey,
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
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(13, 13, 10, 13),
                        labelText: 'Email',
                        labelStyle: kLabelStyle,
                        hintText: 'youremail@example.com',
                        hintStyle: kHintTextStyle,
                        border: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.redAccent, width: 2.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.redAccent, width: 2.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.redAccent, width: 2.0)),
                        enabledBorder: const OutlineInputBorder(
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
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(13, 13, 10, 13),
                        labelText: 'Password',
                        labelStyle: kLabelStyle,
                        hintText: 'Your Password',
                        hintStyle: kHintTextStyle,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.redAccent, width: 2.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.redAccent, width: 2.0)),
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          )),
                    ),

                    CustomButton(
                        name: 'LOGIN',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState.validate()) {
                            try {
                              dynamic res =
                                  await _authService.signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);
                              if (res != null) {
                                Navigator.pushNamed(context, homeScreen);
                              }
                            } catch (e) {
                              print("Got Error:$e");
                            }
                          }
                        },
                        color: Colors.redAccent),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    Text('Don\'t have an account?'),
                    // SizedBox(
                    //   height: getProportionateScreenHeight(20),
                    // ),

                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushNamed(context, registerScreen);
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          // decoration: TextDecoration.underline,
                          // backgroundColor: Color.fromARGB(10, 255, 10, 56),
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w400,
                        ),
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
                        buildSocialButtons(
                            FontAwesomeIcons.facebook, Colors.blue, () {}),
                        buildSocialButtons(FontAwesomeIcons.google, Colors.red,
                            () async {
                          try {
                            dynamic res = await _authService.googleSignIn();
                            if (res != null) {
                              Navigator.pushNamed(context, homeScreen);
                            }
                          } catch (e) {
                            print("Got Error:$e");
                          }
                        }),
                        buildSocialButtons(
                            FontAwesomeIcons.spotify, Colors.green, () {}),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildSocialButtons(IconData icon, Color color, Function signIn) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.white)),
      child: IconButton(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          iconSize: 50,
          color: color,
          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: FaIcon(icon),
          onPressed: () {
            signIn();
            print("Pressed");
          }),
    );
  }
}

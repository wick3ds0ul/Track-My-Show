import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/movies_api.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import '../../utils/constants.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/widgets/custom_button.dart';
import 'form_validation.dart';
import 'package:track_my_show/widgets/common_widgets.dart';

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
    SizeConfig().init(context);
    return WillPopScope(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
                        controller: _emailController,
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
                        controller: _passwordController,
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
                          onPressed: () {
                            Navigator.pushNamed(context, forgotPasswordScreen);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      CustomButton(
                          name: 'LOGIN',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState.validate()) {
                              print("OK");
                              print(_passwordController.text);
                              print(_emailController.text);
                              try {
                                print(_passwordController.text);
                                print(_emailController.text);
                                dynamic res = await _authService
                                    .signInWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);
                                FocusScope.of(context).unfocus();
                                if (res != null) {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                  Navigator.pushReplacementNamed(
                                      context, movieScreen);
                                }
                              } catch (e) {
                                showInSnackBar(e.toString(), context);
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
                      InkWell(
                        onTap: () {
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
                          buildSocialButtons(
                              FontAwesomeIcons.google, Colors.red, () async {
                            try {
                              //TODO:Allow to login with different google account
                              dynamic res = await _authService.googleSignIn();
                              if (res != null) {
                                Navigator.pushNamed(context, movieScreen);
                              }
                            } catch (e) {
                              showInSnackBar(e.toString(), context);
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
      ),
      onWillPop: _onWillPop,
    );
  }

  Container buildSocialButtons(IconData icon, Color color, Function f) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 10.0,
                spreadRadius: 2,
                offset: Offset(0, 6),
              )
            ]),
        child: IconButton(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          iconSize: 50,
          color: color,
          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: FaIcon(icon),
          onPressed: f,
        ));
  }

  Future<bool> _onWillPop() {
    return showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExitModlal();
            }) ??
        false;
  }
}

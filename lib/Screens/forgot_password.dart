import 'package:flutter/material.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:track_my_show/widgets/common_widgets.dart';
import 'package:track_my_show/widgets/custom_button.dart';
import 'package:track_my_show/widgets/signin_prompt.dart';

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
            padding:
                const EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, bottom: 10, left: 15),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            // Shadow(
                            //     color: Colors.black.withOpacity(0.3),
                            //     offset: Offset(0, 5),
                            //     blurRadius: 7)
                          ]),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Text(
                        'Enter your registered email address so that we can send a password reset link to that email id'),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  buildEmailTextFormField(_emailController),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
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
                          // print(res.toString());
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
                  SignInPrompt(context, 'Done resetting your password?'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

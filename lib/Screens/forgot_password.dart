import 'package:flutter/material.dart';

import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/utils/size_config.dart';
import 'package:track_my_show/widgets/common_widgets.dart';
import 'package:track_my_show/widgets/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final _emailController = TextEditingController();

  final AuthService _auth = AuthService();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 15, left: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailTextFormField(_emailController),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                CustomButton(
                  name: 'Get Confirmation Email',
                  color: Colors.black,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

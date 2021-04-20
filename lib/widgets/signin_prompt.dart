import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/utils/size_config.dart';

Widget SignInPrompt(BuildContext context, String message) {
  return Column(
    children: [
      SizedBox(
        height: getProportionateScreenHeight(40),
      ),
      Text(message),
      InkWell(
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacementNamed(context, loginScreen);
        },
        child: Text(
          'Sign In',
          style: GoogleFonts.roboto(
            fontSize: 20,
            // decoration: TextDecoration.underline,
            // backgroundColor: Color.fromARGB(10, 255, 10, 56),
            color: Colors.redAccent,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

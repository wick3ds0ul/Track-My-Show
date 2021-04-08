import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/LoginScreen/form_validation.dart';
import 'package:google_fonts/google_fonts.dart';

//EMAIL
Widget buildEmailTextFormField(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.only(bottom: 8, top: 6),
    child: TextFormField(
        controller: controller,
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

//PASSWORD
Widget buildPasswordTextFormField(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.only(bottom: 8, top: 6),
    child: TextFormField(
        controller: controller,
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
        validator: validatePassword),
  );
}

//RESET PASSWORD
Widget buildRePasswordTextFormField(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.only(bottom: 8, top: 6),
    child: TextFormField(
        controller: controller,
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
        validator: validatePassword),
  );
}

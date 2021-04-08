import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    buildTextFormField("E-mail", false),
                    buildTextFormField("Password", true),
                    Container(
                        height: 43,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () {},
                          child: Text("NEXT",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(fontSize: 13),
                                  fontWeight: FontWeight.bold)),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(String text, bool t) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: TextFormField(
        cursorColor: Colors.black,
        obscureText: t,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(13, 13, 10, 13),
          hintText: text,
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
        validator: (value) {},
      ),
    );
  }
}

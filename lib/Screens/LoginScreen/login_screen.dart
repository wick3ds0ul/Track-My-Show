import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:track_my_show/utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/originals/c1/65/1f/c1651f598d212acdfe551f103548e495.png'),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 3.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3.0),
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
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 3.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 3.0),
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
                  height: getProportionateScreenHeight(20),
                ),
                Text('Don\'t have an account?'),
                Text('Sign Up'),
                Text('OR'),
                Text('Login with'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                        icon: FaIcon(FontAwesomeIcons.google),
                        onPressed: () {
                          print("Pressed");
                        }),
                    IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                        icon: FaIcon(FontAwesomeIcons.facebook),
                        onPressed: () {
                          print("Pressed");
                        }),
                    IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                        icon: FaIcon(FontAwesomeIcons.spotify),
                        onPressed: () {
                          print("Pressed");
                        }),
                  ],
                )
              ],
            ),
          ),
        ],
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

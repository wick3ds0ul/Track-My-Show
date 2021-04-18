import 'package:flutter/material.dart';
import 'package:track_my_show/utils/constants.dart';

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
        aspectRatio: 17 / 2,
        child: Container(
          child: MaterialButton(
            color: color,
            child: new Text(
              name,
              style: kButtonTextStyle,
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

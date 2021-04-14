import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final String name;
  TabBarWidget({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 2.5,
          )
        ],
      ),
      // width: MediaQuery.of(context).size.width / 2.5,
      constraints: BoxConstraints(minWidth: 80),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: FittedBox(
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
    );
  }
}

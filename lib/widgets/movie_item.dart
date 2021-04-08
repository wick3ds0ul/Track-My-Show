import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final String id;
  final String title;

  MovieItem({this.id, this.title});

  getDetails(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getDetails(context);
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0x48938FCA), Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        ),
      ),
    );
  }
}

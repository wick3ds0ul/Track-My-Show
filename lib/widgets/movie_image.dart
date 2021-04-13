import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  final String imgUrl;

  const MovieImage({Key key, @required this.imgUrl}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              child: ClipPath(
            clipper: CustomClip(),
            child: Image.network(
              "$imgUrl",
              fit: BoxFit.cover,
            ),
          )),
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "TrackMyShow",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'comfortaa',
                        fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            height: 25,
            bottom: 0,
            left: 5,
            right: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 31);
    path.quadraticBezierTo(
        size.width / 2, size.height + 31, size.width, size.height - 31);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClip oldClipper) {
    return true;
  }
}

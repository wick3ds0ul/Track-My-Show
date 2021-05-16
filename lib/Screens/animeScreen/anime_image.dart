import 'package:flutter/material.dart';

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

class AnimeImage extends StatefulWidget {
  final String imageUrl;
  const AnimeImage({this.imageUrl, Key key}) : super(key: key);

  @override
  _AnimeImageState createState() => _AnimeImageState();
}

class _AnimeImageState extends State<AnimeImage> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AppUser>(context);
    // print(user.uid);
    // DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      height: MediaQuery.of(context).size.height / 1.6,
      child: Stack(
        children: [
          Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              top: 0,
              child: ClipPath(
                clipper: CustomClip(),
                child: Image.network(
                  "${widget.imageUrl}",
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
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 3.0,
                        offset: Offset(0, 1)),
                  ],
                ),
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.add,
                  // (widget.isPresent) ? Icons.delete : Icons.add,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

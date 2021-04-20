import 'package:flutter/material.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/models/ShowModels/show_model.dart';
import 'package:track_my_show/models/user.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/services/database_service.dart';
import 'package:track_my_show/widgets/common_widgets.dart';

class ShowImage extends StatefulWidget {
  final String imgUrl;
  final MovieModel movie;
  final ShowModel show;

  bool isPresent;
  ShowImage(
      {Key key, @required this.imgUrl, this.movie, this.show, this.isPresent})
      : super(key: key);

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user.uid);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
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
                  "${widget.imgUrl}",
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
              onTap: () async {
                if (widget.isPresent) {
                  try {
                    await _databaseService
                        .deleteShow(widget.show.id.toString());
                    showInSnackBar("Show Deleted", context);
                    setState(() {
                      widget.isPresent = !widget.isPresent;
                    });
                  } catch (e) {
                    print(e.toString());
                    showInSnackBar(e.toString(), context);
                  }
                } else {
                  try {
                    await _databaseService.addShow(widget.show);
                    showInSnackBar("Show Added", context);
                    setState(() {
                      widget.isPresent = !widget.isPresent;
                    });
                  } catch (e) {
                    print(e.toString());
                    showInSnackBar(e.toString(), context);
                  }
                }
              },
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
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  (widget.isPresent) ? Icons.delete : Icons.add,
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

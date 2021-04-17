import 'package:flutter/material.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/models/ShowModels/show_model.dart';
import 'package:track_my_show/models/user.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/services/database_service.dart';
import 'package:track_my_show/services/firebase_errors.dart';
import 'package:track_my_show/widgets/common_widgets.dart';

class MovieImage extends StatelessWidget {
  final String imgUrl;
  final MovieModel movie;
  final ShowModel show;
  const MovieImage({Key key, @required this.imgUrl, this.movie, this.show})
      : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user.uid);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
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
            height: 40,
            bottom: 0,
            // left: 20,
            right: 155,
            child: InkWell(
              onTap: () async {
                if (movie != null) {
                  print("Movie is not null");
                  print(movie);
                  bool check = await _databaseService
                      .checkMoviePresent(movie.id.toString());
                  //item already present
                  if (check) {
                    showInSnackBar("Movie Already Added", context);
                  } else {
                    try {
                      await _databaseService.addMovie(movie);
                      showInSnackBar("Movie Added", context);
                    } catch (e) {
                      print(e.toString());
                      showInSnackBar(e.toString(), context);
                    }
                  }
                }
                if (show != null) {
                  print("Show is not null");
                  print(show);
                  bool check = await _databaseService
                      .checkShowPresent(show.id.toString());
                  //item already present
                  if (check) {
                    showInSnackBar("Show Already Added", context);
                  } else {
                    try {
                      await _databaseService.addShow(show);
                      showInSnackBar("Show Added", context);
                    } catch (e) {
                      print(e.toString());
                      showInSnackBar(e.toString(), context);
                    }
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54),
                height: 50,
                child: Icon(
                  Icons.add,
                  color: Color(0xFFFF0000),
                  size: 40,
                ),

                // onPressed:
              ),
            ),
          ),
          // child: Row(

          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[

          //     IconButton(
          //       icon: Icon(Icons.share),
          //       onPressed: () {
          //         _databaseService.checkMoviePresent(movie.id.toString());
          //       },
          //     ),
          //   ],
          // ),
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

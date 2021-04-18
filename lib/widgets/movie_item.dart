import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:track_my_show/models/MovieModels/featured_movie_model.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/models/basic_model.dart';

class MovieItem extends StatelessWidget {
  final BasicModel snapshot;

  const MovieItem({
    Key key,
    this.snapshot,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        snapshot.content_type == "movie"
            ? Navigator.of(context)
                .pushNamed(movieDetailsScreen, arguments: snapshot.id)
            : Navigator.of(context)
                .pushNamed(showDetailsScreen, arguments: snapshot.id);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0, color: Colors.grey[400], offset: Offset(0, 3))
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.none,
                  imageUrl: getTileImage(snapshot.poster_path),
                  // imageUrl: getPosterImage(snapshot.poster_path),
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => Container(
                  //   child: Center(child: CircularProgressIndicator()),
                  // ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // child: Image.network(
                //   // movieList[id]['img'],
                //   getPosterImage(snapshot.poster_path),
                //   fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Text(
                  // "${movieList[id]['title']}",
                  snapshot.original_title,
                  style: TextStyle(
                    // fontFamily: 'Comfortaa',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//   final String id;
//   final String title;

//   MovieItem({this.id, this.title});

//   getDetails(BuildContext context) {}
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         getDetails(context);
//       },
//       borderRadius: BorderRadius.circular(15),
//       child: Container(
//         padding: EdgeInsets.all(15),
//         child: Text(
//           title,
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Color(0x48938FCA), Colors.blue],
//               begin: Alignment.topLeft,
//               end: Alignment.topRight),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(5), topRight: Radius.circular(5)),
//         ),
//       ),
//     );
//   }
// }

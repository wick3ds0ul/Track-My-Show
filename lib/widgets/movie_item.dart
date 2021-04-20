import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/Screens/showScreen/show_details_screen.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/database_service.dart';
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
    final user = Provider.of<AppUser>(context);
    print(user.uid);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);

    return GestureDetector(
      onTap: () async {
        if (snapshot.content_type == "movie") {
          bool isMoviePresentInFirebaseDB =
              await _databaseService.checkMoviePresent(snapshot.id);
          Navigator.of(context).pushNamed(movieDetailsScreen, arguments: {
            'snapid': snapshot.id,
            'uid': user.uid,
            'isPresent': isMoviePresentInFirebaseDB
          });
        } else {
          bool isShowPresentInFirebaseDB =
              await _databaseService.checkShowPresent(snapshot.id);
          Map<String, Object> data = {
            'snapid': snapshot.id,
            'uid': user.uid,
            'isPresent': isShowPresentInFirebaseDB
          };
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ShowDetailsScreen(args: data);
          }));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: const EdgeInsets.all(5.0),
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
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Text(
                  snapshot.original_title,
                  style: const TextStyle(
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/Screens/showScreen/show_details_screen.dart';
import 'package:track_my_show/models/MovieModels/search_item.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/database_service.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/services/movies_api.dart';

class DataSearch extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return FutureBuilder<List<SearchItem>>(
      future: MoviesApi().searchItems(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(child: Text('Enter a valid query.'));
          } else {
            // print(snapshot.data);
            List<SearchItem> searchItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return searchItems[index].checkNullValues()
                    ? const SizedBox.shrink()
                    : Card(
                        child: ListTile(
                          leading: Image.network(
                            getPosterImage(searchItems[index].imageURL),
                            fit: BoxFit.cover,
                          ),
                          title: Text('${searchItems[index].name}'),
                          subtitle: Text(
                            '${searchItems[index].overview}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          ),
                          trailing: Text(
                            '${searchItems[index].media_type}'.toUpperCase(),
                          ),
                          onTap: () async {
                            if (snapshot.data[index].content_type == "movie") {
                              bool isMoviePresentInFirebaseDB =
                                  await _databaseService.checkMoviePresent(
                                      snapshot.data[index].id);
                              Navigator.of(context)
                                  .pushNamed(movieDetailsScreen, arguments: {
                                'snapid': snapshot.data[index].id,
                                'uid': user.uid,
                                'isPresent': isMoviePresentInFirebaseDB
                              });
                            } else {
                              bool isShowPresentInFirebaseDB =
                                  await _databaseService.checkShowPresent(
                                      snapshot.data[index].id);
                              Map<String, Object> data = {
                                'snapid': snapshot.data[index].id,
                                'uid': user.uid,
                                'isPresent': isShowPresentInFirebaseDB
                              };
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ShowDetailsScreen(args: data);
                              }));
                            }
                          },
                        ),
                      );
              },
              itemCount: searchItems.length,
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator()); // loading
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for AppBar
    return [
      //This will clear the text
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
          })
    ];
    // throw UnimplementedError(); height: MediaQuery.of(context).size.height * 0.87,
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Leading icon on the left of AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
          // Navigator.of(context).pop();
        });
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something
    return Container();
  }
}

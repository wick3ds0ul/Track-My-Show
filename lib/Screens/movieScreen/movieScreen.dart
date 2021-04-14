import 'package:flutter/material.dart';
import 'package:track_my_show/models/MovieModels/action_movies_model.dart';
import 'package:track_my_show/models/MovieModels/adventure_movies_model.dart';
import 'package:track_my_show/models/MovieModels/animation_movie_model.dart';
import 'package:track_my_show/models/MovieModels/featured_movie_model.dart';
import 'package:track_my_show/models/MovieModels/genre_model.dart';
import 'package:track_my_show/services/movies_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/movie_item.dart';
// import 'package:track_my_show/services/api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/models/MovieModels/search_item.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import 'ui/action.dart';
import 'ui/adventure.dart';
import 'ui/animation.dart';
import 'ui/featured.dart';
import 'ui/tabbar.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/router/routenames.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final AuthService _auth = AuthService();
  Future<List<FeaturedMovieModel>> featuredMovies;
  Future<List<GenreModel>> genreList;
  Future<List<ActionMovieModel>> actionMovies;
  Future<List<AdventureMovieModel>> adventureMovies;
  Future<List<AnimationMovieModel>> animationMovies;

  MoviesApi _api;
  @override
  void initState() {
    super.initState();
    _api = MoviesApi();
    featuredMovies = _api.getFeaturedMovies();
    actionMovies = _api.getActionMovies();
    adventureMovies = _api.getAdventureMovies();
    animationMovies = _api.getAnimationMovies();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              //This is search Button
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              ),
              drawer: CustomDrawer(auth: _auth),
              appBar: AppBar(
                title: Text(
                  'Homepage',
                  style:
                      TextStyle(fontFamily: 'Comfortaa', color: Colors.black),
                ),
                backgroundColor: Color(0xFFFFFFFF),
                leading: Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu_open_rounded),
                    color: Colors.black,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                }),
                bottom: TabBar(
                  indicatorColor: Color(0xFFFF2929),
                  isScrollable: true,
                  tabs: [
                    TabBarWidget(
                      name: "Featured",
                    ),
                    TabBarWidget(
                      name: "Action",
                    ),
                    TabBarWidget(
                      name: "Adventure",
                    ),
                    TabBarWidget(
                      name: "Animation",
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                FeaturedTabContent(featuredMovies: featuredMovies),
                ActionTabContent(actionMovies: actionMovies),
                AdventureTabContent(adventureMovies: adventureMovies),
                AnimationTabContent(animationMovies: animationMovies),
              ]),
              backgroundColor: Color(0xFFFFFFFF),
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExitModlal();
            }) ??
        false;
  }
}

class DataSearch extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<SearchItem>>(
      future: MoviesApi().searchItems(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Center(child: Text('Enter a valid query.'));
          } else {
            // print(snapshot.data);
            List<SearchItem> searchItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return searchItems[index].checkNullValues()
                    ? SizedBox.shrink()
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
                          onTap: () {
                            print(
                                "SEARCH API with ID:${searchItems[index].id}");
                            searchItems[index].media_type == 'tv'
                                ? Navigator.of(context).pushNamed(
                                    showDetailsScreen,
                                    arguments: searchItems[index].id)
                                : Navigator.pushNamed(
                                    context, movieDetailsScreen,
                                    arguments: searchItems[index].id);
                          },
                        ),
                      );
              },
              itemCount: searchItems.length,
            );
          }
        } else {
          return Center(child: CircularProgressIndicator()); // loading
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
    // throw UnimplementedError();
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_my_show/models/action_movies_model.dart';
import 'package:track_my_show/models/featured_movie_model.dart';
import 'package:track_my_show/models/genre_model.dart';
import 'package:track_my_show/models/movie.dart';
import 'package:track_my_show/services/api.dart';
import 'package:track_my_show/widgets/movie_item.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import '../../data/movie_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  Future<List<FeaturedMovieModel>> featuredMovies;
  Future<List<GenreModel>> genreList;
  Future<List<ActionMovieModel>> actionMovies;

  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    featuredMovies = _api.getFeaturedMovies();
    actionMovies = _api.getActionMovies();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: SizedBox.shrink(),
                actions: [
                  TextButton(
                      onPressed: () async {
                        await _auth.signOutNormal().then((_) {
                          print("Done");
                          Navigator.pushReplacementNamed(context, loginScreen);
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      child: Text('Logout'))
                ],
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    // Tab(
                    //   icon: Icon(Icons.featured_play_list_outlined),
                    //   text: "Featured",
                    // ),
                    // Tab(
                    //   icon: Icon(Icons.movie),
                    //   text: "Action",
                    // ),
                    TabNames(name: "Action"),
                    TabNames(name: "Thriller"),
                  ],
                ),
              ),
              body: TabBarView(children: [
                FeatureTabContent(featuredMovies: featuredMovies),
                ActionTabContent(actionMovies: actionMovies)
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

class FeatureTabContent extends StatelessWidget {
  const FeatureTabContent({
    Key key,
    @required this.featuredMovies,
  }) : super(key: key);

  final Future<List<FeaturedMovieModel>> featuredMovies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<FeaturedMovieModel>>(
              future: featuredMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemBuilder: (ctx, id) {
                      return MovieItem(
                        snapshot: snapshot.data[id],
                      );
                    },
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 4 / 5,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                  );
                } else {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActionTabContent extends StatelessWidget {
  const ActionTabContent({
    Key key,
    @required this.actionMovies,
  }) : super(key: key);

  final Future<List<ActionMovieModel>> actionMovies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<ActionMovieModel>>(
              future: actionMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemBuilder: (ctx, id) {
                      return MovieItem(
                        snapshot: snapshot.data[id],
                      );
                    },
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 4 / 5,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                  );
                } else {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TabNames extends StatelessWidget {
  final String name;
  const TabNames({Key key, this.name}) : super(key: key);

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
      constraints: BoxConstraints(minWidth: 150),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Text(
        "${name}",
        style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
      ),
    );
  }
}

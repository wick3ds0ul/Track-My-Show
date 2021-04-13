import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_my_show/models/MovieModels/action_movies_model.dart';
import 'package:track_my_show/models/MovieModels/adventure_movies_model.dart';
import 'package:track_my_show/models/MovieModels/animation_movie_model.dart';
import 'package:track_my_show/models/MovieModels/featured_movie_model.dart';
import 'package:track_my_show/models/MovieModels/genre_model.dart';
import 'package:track_my_show/models/MovieModels/genre_movies_model.dart';
import 'package:track_my_show/models/MovieModels/movie.dart';
import 'package:track_my_show/services/api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/movie_item.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import '../../data/movie_data.dart';

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

  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
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

class TabBarWidget extends StatelessWidget {
  final String name;
  TabBarWidget({Key key, this.name}) : super(key: key);

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
      constraints: BoxConstraints(minWidth: 80),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: FittedBox(
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
    );
  }
}

class FeaturedTabContent extends StatelessWidget {
  const FeaturedTabContent({
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
                    child: CircularProgressIndicator(),
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
                    child: CircularProgressIndicator(),
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

class AdventureTabContent extends StatelessWidget {
  const AdventureTabContent({
    Key key,
    @required this.adventureMovies,
  }) : super(key: key);

  final Future<List<AdventureMovieModel>> adventureMovies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<AdventureMovieModel>>(
              future: adventureMovies,
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
                    child: CircularProgressIndicator(),
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

class AnimationTabContent extends StatelessWidget {
  const AnimationTabContent({
    Key key,
    @required this.animationMovies,
  }) : super(key: key);

  final Future<List<AnimationMovieModel>> animationMovies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<AnimationMovieModel>>(
              future: animationMovies,
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
                    child: CircularProgressIndicator(),
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

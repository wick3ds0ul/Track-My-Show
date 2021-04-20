import 'package:flutter/material.dart';
import 'package:track_my_show/models/MovieModels/action_movies_model.dart';
import 'package:track_my_show/models/MovieModels/adventure_movies_model.dart';
import 'package:track_my_show/models/MovieModels/animation_movie_model.dart';
import 'package:track_my_show/models/MovieModels/featured_movie_model.dart';
import 'package:track_my_show/models/MovieModels/genre_model.dart';
import 'package:track_my_show/services/movies_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/data_search.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import 'ui/action.dart';
import 'ui/adventure.dart';
import 'ui/animation.dart';
import 'ui/featured.dart';
import 'ui/tabbar.dart';

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
                  showSearch(
                    context: context,
                    delegate: DataSearch(),
                  );
                },
              ),
              drawer: CustomDrawer(auth: _auth),
              appBar: AppBar(
                toolbarHeight: 70,
                title: Text(
                  'Movies',
                  style:
                      TextStyle(fontFamily: 'Comfortaa', color: Colors.black),
                ),
                backgroundColor: const Color(0xFFFFFFFF),
                leading: Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu_open_rounded),
                    color: Colors.black,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                }),
                bottom: TabBar(
                  indicatorColor: const Color(0xFFFF2929),
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
              backgroundColor: const Color(0xFFFFFFFF),
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

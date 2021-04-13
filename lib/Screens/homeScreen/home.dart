import 'package:flutter/material.dart';
import 'package:track_my_show/models/action_movies_model.dart';
import 'package:track_my_show/models/adventure_movies_model.dart';
import 'package:track_my_show/models/animation_movie_model.dart';
import 'package:track_my_show/models/featured_movie_model.dart';
import 'package:track_my_show/models/genre_model.dart';
import 'package:track_my_show/services/api.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import '../../data/movie_data.dart';
import 'ui/action.dart';
import 'ui/adventure.dart';
import 'ui/animation.dart';
import 'ui/featured.dart';
import 'ui/tabbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              drawer: Drawer(),
              appBar: AppBar(
                title: Text(
                  'Homepage',
                  style:
                      TextStyle(fontFamily: 'Comfortaa', color: Colors.black),
                ),
                backgroundColor: Color(0xFFFFFFFF),
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      }),
                  TextButton(
                    onPressed: () async {
                      await _auth.signOutNormal().then((_) {
                        print("Done");
                        Navigator.pushReplacementNamed(context, loginScreen);
                      }).catchError((error) {
                        print(error);
                      });
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Comfortaa', color: Colors.blue),
                    ),
                  ),
                ],
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
      future: Api().searchItems(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Center(child: Text('Could Not find Data'));
          } else {
            print(snapshot.data);
            List<SearchItem> searchItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                // return Text(
                //     '${searchItems[index].name}${searchItems[index].imageURL}${searchItems[index].desc}');
                return Card(
                  child: ListTile(
                    leading: Image.network(
                        getPosterImage(searchItems[index].imageURL)),
                    title: Text('${searchItems[index].name}'),
                    subtitle: Text(
                      '${searchItems[index].desc}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              },
              itemCount: searchItems.length,
            );
          }
        } else {
          return CircularProgressIndicator(); // loading
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

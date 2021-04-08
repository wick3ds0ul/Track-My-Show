import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    featuredMovies = _api.getFeaturedMovies();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
          ),
          body: SingleChildScrollView(
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
                                id: id.toString(),
                                title: snapshot.data[id].original_title);
                          },
                          itemCount: snapshot.data.length,
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 4 / 5,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
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
          ),
          backgroundColor: Color(0xFF130909),
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

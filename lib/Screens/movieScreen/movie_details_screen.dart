import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/services/database_service.dart';
import 'package:track_my_show/services/movies_api.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/widgets/movie_image.dart';
import 'package:track_my_show/models/user.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/models/user.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Map<String, Object> args;
  const MovieDetailsScreen({Key key, this.args}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<MovieDetailsScreen> {
  MoviesApi _api;
  Future<MovieModel> movieModel, movieModelPresent;
  DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();
    _api = MoviesApi();
    movieModel = _api.getMovieInfo(widget.args['snapid']);
    _databaseService = DatabaseService(uid: widget.args['uid']);
    movieModelPresent = _databaseService.getMovieByID(widget.args['snapid']);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<MovieModel>(
          future: (!widget.args['isPresent']) ? movieModel : movieModelPresent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MovieModel movie = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MovieImage(
                      movie: movie,
                      imgUrl: getPosterImage(snapshot.data.poster_path),
                      isPresent: widget.args['isPresent'],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${snapshot.data.original_title}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: List.generate(
                                snapshot.data.genre.length,
                                (i) {
                                  return TextSpan(
                                      text:
                                          "${snapshot.data.genre[i]['name']}");
                                },
                              ),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          const SizedBox(height: 9.0),
                          RatingBar.builder(
                            initialRating: snapshot.data.rating,
                            // initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 10,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 25,
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          const SizedBox(height: 13.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Year",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    "${DateTime.parse(snapshot.data.release_date).year}",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Country",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    "${snapshot.data.country}",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Length",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    "${snapshot.data.run_time}min",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 13.0),
                          Container(
                            // TODO stylized the dropdown button
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: const Color(0xFF858484))),
                            child: DropdownButton(
                              //staus either from DB or default from class
                              value: snapshot.data.status ?? 'Want to Watch',
                              items: const <String>[
                                'Watching',
                                'Completed',
                                'OnHold',
                                'Want to Watch',
                                'Dropped'
                              ].map<DropdownMenuItem<String>>(
                                  (String selectedValue) {
                                return DropdownMenuItem<String>(
                                  value: selectedValue,
                                  child: Text(selectedValue),
                                );
                              }).toList(),
                              onChanged: (String value) async {
                                setState(() {
                                  snapshot.data.status = value;
                                });
                                MovieModel movie = snapshot.data;
                                if (widget.args['isPresent']) {
                                  print(snapshot.data.status);
                                  try {
                                    await _databaseService.updateMovie(movie);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                }
                              },
                              elevation: 5,
                              icon: const Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.blue,
                              ),
                              iconSize: 42,
                              focusColor: const Color(0xFFF08080),
                            ),
                          ),
                          const SizedBox(height: 13.0),
                          Text(
                            "${snapshot.data.overview}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .apply(fontSizeFactor: 1.2),
                          ),
                          const SizedBox(height: 13.0),
                        ],
                      ),
                    ),
                    // MyScreenshots(),
                    const SizedBox(height: 13.0),
                  ],
                ),
              );
            } else {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

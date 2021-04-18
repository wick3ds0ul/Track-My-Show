import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/services/movies_api.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/widgets/movie_image.dart';
import '../data/tv_genre.dart';

//TODO:Trash
class TVDetailScreen extends StatefulWidget {
  final String name;

  TVDetailScreen({this.name});

  @override
  _TVDetailScreenState createState() => _TVDetailScreenState();
}

class _TVDetailScreenState extends State<TVDetailScreen> {
  MoviesApi _api;
  Future<TV> tvModel;
  @override
  void initState() {
    _api = MoviesApi();
    tvModel = _api.getTVInfo(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<TV>(
          future: tvModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              TV show = snapshot.data;
              List<String> genreNames = [];
              for (int i = 0; i < show.genre.length; i++) {
                print("Item:${show.genre[i]}");
                String genre = getTVGenreName(show.genre[i].toString());
                genreNames.add(genre);
              }
              print("Gnere Length:${show.genre.length}");
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MovieImage(
                      imgUrl: getPosterImage(show.poster_path),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${show.original_title}",
                            style: Theme.of(context).textTheme.headline,
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: List.generate(
                                genreNames.length,
                                (i) {
                                  return TextSpan(text: "${genreNames[i]}");
                                },
                              ),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          SizedBox(height: 9.0),
                          RatingBar.builder(
                            initialRating: snapshot.data.rating,
                            // initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 25,
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(height: 13.0),
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
                                    "${DateTime.parse(show.release_date).year}",
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
                                    "${show.country}",
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
                                    "N/A \n min",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 13.0),
                          Text(
                            "${snapshot.data.overview}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .apply(fontSizeFactor: 1.2),
                          ),
                          SizedBox(height: 13.0),
                        ],
                      ),
                    ),
                    // MyScreenshots(),
                    SizedBox(height: 13.0),
                  ],
                ),
              );
              // return Text("${show.overview}${show.original_title}");
            }
            if (snapshot.hasError) {
              return Text('Has Error${snapshot.hasError}');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

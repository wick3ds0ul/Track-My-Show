import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/Screens/animeScreen/anime_image.dart';
import 'package:track_my_show/models/AnimeModels/anime_model.dart';
import 'package:track_my_show/models/user.dart';

class AnimeDetailScreen extends StatefulWidget {
  final AnimeModel anime;
  const AnimeDetailScreen({this.anime, Key key}) : super(key: key);

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AnimeImage(
                  imageUrl: widget.anime.posterImage,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${widget.anime.canonicalTitle}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Text(
                        "${widget.anime.ageRatingGuide}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 9.0),
                      RatingBar.builder(
                        // initialRating: ,
                        initialRating: 3,
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
                                "${DateTime.parse(widget.anime.startDate).year}",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                          widget.anime.episodeCount != null
                              ? Column(
                                  children: <Widget>[
                                    Text(
                                      "Total Episodes",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      "${widget.anime.episodeCount}",
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    Text(
                                      "Total Length",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      "${widget.anime.totalLength}",
                                      style:
                                          Theme.of(context).textTheme.subhead,
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
                                "${widget.anime.episodeLength}min",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 13.0),
                      // Container(
                      //   // TODO stylized the dropdown button
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 0),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //           width: 2, color: Color(0xFF858484))),
                      //   child: DropdownButton(
                      //     //staus either from DB or default from class
                      //     value: snapshot.data.status,
                      //     items: <String>[
                      //       'Watching',
                      //       'Completed',
                      //       'OnHold',
                      //       'Want to Watch',
                      //       'Dropped'
                      //     ].map<DropdownMenuItem<String>>(
                      //             (String selectedValue) {
                      //           return DropdownMenuItem<String>(
                      //             value: selectedValue,
                      //             child: Text(selectedValue),
                      //           );
                      //         }).toList(),
                      //     onChanged: (String value) async {
                      //       setState(() {
                      //         snapshot.data.status = value;
                      //       });
                      //       MovieModel movie = snapshot.data;
                      //       if (widget.args['isPresent']) {
                      //         print(snapshot.data.status);
                      //         try {
                      //           // Future res =
                      //           await _databaseService.updateMovie(
                      //               movie.id.toString(), movie.status);
                      //           //   TODO:2 writes.Fix to 1 write using update.
                      //           // await _databaseService.deleteMovie(
                      //           //     snapshot.data.id.toString());
                      //           // await _databaseService
                      //           //     .addMovie(snapshot.data);
                      //           // print(res);
                      //         } catch (e) {
                      //           print(e.toString());
                      //         }
                      //       }
                      //     },
                      //     elevation: 5,
                      //     icon: Icon(
                      //       Icons.arrow_drop_down_sharp,
                      //       color: Colors.blue,
                      //     ),
                      //     iconSize: 42,
                      //     focusColor: Color(0xFFF08080),
                      //   ),
                      // ),
                      SizedBox(height: 13.0),
                      Text(
                        "${widget.anime.description}",
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
          )),
    );
  }
}

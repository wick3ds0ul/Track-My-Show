import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:track_my_show/models/ShowModels/show_model.dart';
import 'package:track_my_show/services/database_service.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/services/shows_api.dart';
import 'package:track_my_show/widgets/show_image.dart';

class ShowDetailsScreen extends StatefulWidget {
  final Map<String, Object> args;

  const ShowDetailsScreen({Key key, this.args}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<ShowDetailsScreen> {
  ShowsApi _api;
  Future<ShowModel> showModel, showModelPresent;
  DatabaseService _databaseService;
  @override
  void initState() {
    super.initState();
    _api = ShowsApi();
    showModel = _api.getShowInfo(widget.args['snapid']);
    _databaseService = DatabaseService(uid: widget.args['uid']);
    showModelPresent = _databaseService.getShowByID(widget.args['snapid']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<ShowModel>(
          future: (!widget.args['isPresent']) ? showModel : showModelPresent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ShowModel show = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ShowImage(
                      show: show,
                      imgUrl: getPosterImage(snapshot.data.poster_path),
                      isPresent: widget.args['isPresent'],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${snapshot.data.original_title}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: List.generate(
                                snapshot.data.genre.length,
                                (i) {
                                  return TextSpan(
                                      text:
                                          "${snapshot.data.genre[i]['name']} ");
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
                                    "${snapshot.data.run_time} min",
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 13.0),
                          Container(
                            // TODO stylized the dropdown button
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Color(0xFF858484))),
                            child: DropdownButton(
                              //staus either from DB or default from class
                              value: snapshot.data.status,
                              items: <String>[
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
                                ShowModel show = snapshot.data;
                                if (widget.args['isPresent']) {
                                  print(snapshot.data.status);
                                  try {
                                    await _databaseService.updateShow(show);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                }
                              },
                              elevation: 5,
                              icon: Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.blue,
                              ),
                              iconSize: 42,
                              focusColor: Color(0xFFF08080),
                            ),
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

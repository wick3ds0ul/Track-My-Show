import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/models/ShowModels/show_model.dart';
import 'package:track_my_show/models/basic_model.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/utils/size_config.dart';
import '../../services/database_service.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/widgets/movie_item.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user.uid);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return Scaffold(
        appBar: AppBar(
          title: Text('My Library'),
          actions: [
            IconButton(icon: Icon(Icons.more_vert_outlined), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                //movie
                child: StreamBuilder<List<MovieModel>>(
                    stream: _databaseService.movies,
                    builder: (context, snapshot1) {
                      //shows
                      return StreamBuilder<List<ShowModel>>(
                          stream: _databaseService.shows,
                          builder: (context, snapshot2) {
                            if (snapshot1.hasData && snapshot2.hasData) {
                              List<MovieModel> movies = snapshot1.data;
                              List<ShowModel> shows = snapshot2.data;
                              final List<BasicModel> items = [
                                ...movies,
                                ...shows
                              ];
                              return GridView.builder(
                                itemBuilder: (ctx, id) {
                                  return MovieItem(
                                    snapshot: items[id],
                                  );
                                },
                                itemCount: items.length,
                                padding: const EdgeInsets.all(5),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 4 / 5,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                              );

                              // return Text("Got data");
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          });
                    }),
              )
            ],
          ),
        ));
  }
}

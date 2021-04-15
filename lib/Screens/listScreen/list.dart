import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/database_service.dart';
import 'package:track_my_show/services/global.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final countries = [
    'Pakistan',
    'France',
    'Spain',
    'KSA',
    'Brasil',
    'Australia',
    'UAE',
    'USA',
    'UK',
    'India',
    'Afghanistan',
    'Bangladsh',
    'Egypt',
    'Pakistan',
    'France',
    'Spain',
    'KSA',
    'Brasil',
    'Australia',
    'UAE',
    'USA',
    'UK',
    'India',
    'Afghanistan',
    'Bangladsh',
    'Egypt'
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user.uid);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return Scaffold(
      body: StreamBuilder<List<MovieModel>>(
          stream: _databaseService.movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<MovieModel> movies = snapshot.data;
              print('Length of movies in DB:${movies.length}');
              for (var data in movies) {
                print(data);
              }
              return movies.length == 0
                  ? Center(
                      child: Text("Nothing to show here"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: movies.length,
                        itemBuilder: (ctx, i) {
                          print("List Data:${movies.length}");
                          return ListTile(
                            title: Text(movies[i].original_title),
                            onTap: () {
                              Navigator.pushNamed(context, movieDetailsScreen,
                                  arguments: movies[i].id);
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                    getPosterImage(movies[i].poster_path)),
                                radius: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // child: FittedBox(
                                  //   child: Text(
                                  //     'Null',
                                  //   ),
                                  // ),
                                )),
                            trailing: TextButton(
                              onPressed: () async {
                                print("Before delete");
                                await _databaseService
                                    .deleteMovie(movies[i].id.toString());
                                print("Before delete");
                              },
                              child: Text('Delete'),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, i) {
                          return Divider();
                        },
                      ),
// child: MovieCards(),
                    );
            } else {
              return Text("Error");
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:track_my_show/models/MovieModels/adventure_movies_model.dart';
import 'package:track_my_show/widgets/movie_item.dart';

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
                    child: Text("Loading..."),
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

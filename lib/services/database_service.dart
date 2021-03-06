import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_my_show/models/user.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'firebase_errors.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Users collection
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  //Movies Collection
  final CollectionReference showCollection =
      FirebaseFirestore.instance.collection('shows');
  //TODO:
  //First Time Users-Add user Data on signup
  Future updateUserData(UserData userData) async {
    return await userDataCollection.doc(uid).set(
      {
        "uid": userData.uid,
        "displayName": userData.displayName,
        "email": userData.email,
        "emailVerified": userData.emailVerified,
        //this is not required.Just for test purpose
        "photoURL": userData.photoURL,
      },
    );
  }

  //Add a new Movie
  Future addMovie(MovieModel movie) async {
    return await showCollection
        .doc(uid)
        .collection('movies')
        .doc('${movie.id}')
        .set(
      {
        'id': movie.id,
        'run_time': movie.run_time,
        'rating': movie.rating,
        'genre': movie.genre,
        'original_title': movie.original_title,
        'overview': movie.overview,
        'poster_path': movie.poster_path,
        'country': movie.country,
        'release_date': movie.release_date
      },
    );
  }

  //Delete Movie
  Future deleteMovie(String id) async {
    await showCollection.doc(uid).collection('movies').doc(id).delete();
  }

  //Helper
  List<MovieModel> _movieSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return MovieModel(
          original_title: doc.data()['original_title'],
          overview: doc.data()['overview'],
          poster_path: doc.data()['poster_path'],
          id: doc.data()['id'],
          country: doc.data()['country'],
          release_date: doc.data()['release_date'],
          run_time: doc.data()['run_time'],
          genre: doc.data()['genre'],
          rating: doc.data()['rating'].toDouble());
    }).toList();
  }

//Read Movie in realtime
  Stream<List<MovieModel>> get movies {
    return showCollection
        .doc(uid)
        .collection('movies')
        .snapshots()
        .map(_movieSnapshot);
  }

  //Check if movie present in collection

  Future<bool> checkMoviePresent(String id) async {
    final item =
        await showCollection.doc(uid).collection('movies').doc(id).get();
    if (item.exists) {
      print("Item here");
      return true;
    } else {
      print("Item not here");
      return false;
    }
  }
}

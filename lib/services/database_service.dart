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

  Stream<DocumentSnapshot> get movies {
    return showCollection.doc(uid).collection('movies').doc().snapshots();
  }
}

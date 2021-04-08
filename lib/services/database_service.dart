import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_my_show/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Users collection
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');

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
}

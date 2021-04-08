class AppUser {
  String uid;
  AppUser({this.uid});
}

//Example of User from firebase Object
//User(displayName: null, email: null, emailVerified: false, isAnonymous: true, metadata: UserMetadata(creationTime: 2021-03-17 11:07:16.592, lastSignInTime: 2021-03-17 11:07:16.592), phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null, uid: OS17XNHPeOdC33SOU4nh8tZ9PfD3)
class UserData {
  String uid;
  String displayName;
  String email;
  bool emailVerified;
  String photoURL;

  UserData(
      {this.uid,
      this.displayName,
      this.email,
      this.emailVerified,
      this.photoURL});
}

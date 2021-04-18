import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:track_my_show/models/user.dart';
import 'database_service.dart';
import 'firebase_errors.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);

      User user = authResult.user;

      print("User Name: ${user.displayName}");
      print("User Email ${user.email}");

      ///Convert user From Firebase to UserData Object
      UserData userData = _makeUserDataFromAuthUser(user);

      ///This holds default values for new users
      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }

  //Google sign-out
  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  //Firebase User to App User
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //SignIn Anonymously
  Future<AppUser> signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      ///Convert user From Firebase to UserData Object
      UserData userData = _makeUserDataFromAuthUser(user);

      ///This holds default values for new users
      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }

  //Register with email and password

//register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //Send email verification
      // await user.sendEmailVerification();
      //TODO:Implement email verification
      UserData userData = _makeUserDataFromAuthUser(user);
      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _userFromFirebaseUser(user);

      ///Convert user From Firebase to UserData Object
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }

  //Sign-out
  Future<void> signOutNormal() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }

//TODO:Implement forgot/reset password
  //Forgot password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }
  //TODO:Check if email is already registered

  Future checkEmail(String email) async {
    try {
      dynamic res = await _auth.fetchSignInMethodsForEmail(email);
      return res;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage = firebaseErrors(e.code);
      return Future.error(errorMessage);
    }
  }

//TODO:Implement verify email
  //Verify email
  ///HELPER
  UserData _makeUserDataFromAuthUser(User user) {
    //IMP:DO NOT REMOVE THIS URL,this is the default image while signing up.
    //Change Image as per needed.A valid URL must be provided
    String photoUrl =
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80";
    UserData userData = UserData(
      uid: user.uid,
      displayName: user.displayName ?? "Your name",
      email: user.email ?? "your@email.com",
      //todo:Implement verify email
      emailVerified: user.emailVerified,
      photoURL: user.photoURL ?? photoUrl,
    );
    return userData;
  }

  //Sign in with google

  //Handle Errors
  //
  String firebaseErrors(String errorCode) {
    String message;
    switch (errorCode) {
      case 'invalid-email':
        message = 'The email is badly formatted.';
        break;
      case 'unauthorized-domain':
        message = 'This domain is not authorized for OAuth.';
        break;
      case 'popup-closed-by-user':
        message = 'Cancelled by user.';
        break;
      case 'account-exists-with-different-credential':
        message =
            'You already have an account with this email but with different credential.';
        break;
      case 'wrong-password':
        message = 'Invalid User credentials.';
        break;
      case 'network-request-failed':
        message = 'Please check your internet connection';
        break;
      case 'too-many-requests':
        message =
            'You inserted wrong login credentials several times. Take a break please!';
        break;
      case 'user-disabled':
        message =
            'Your account has been disabled or deleted. Please contact the system administrator.';
        break;
      case 'requires-recent-login':
        message = 'Please login again and try again!';
        break;
      case 'email-already-exists':
      case 'email-already-in-use':
        message = 'Email address is already in use by an existing user.';
        break;
      case 'user-not-found':
        message =
            'We could not find user account associated with the email address or phone number.';
        break;
      case 'phone-number-already-exists':
        message = 'The phone number is already in use by an existing user.';
        break;
      case 'invalid-phone-number':
        message = 'The phone number is not a valid phone number!';
        break;
      case 'invalid-email  ':
        message = 'The email address is not a valid email address!';
        break;
      case 'cannot-delete-own-user-account':
        message = 'You cannot delete your own user account.';
        break;
      case 'aborted':
        message = 'Aborted due to errors.';
        break;
      case 'already-exists':
        message = 'The document already exits.';
        break;
      case 'cancelled':
        message = 'Cancelled.';
        break;
      case 'internal':
        message = 'Internal Server Error.';
        break;
      case 'permission-denied':
        message = 'You don\'t have sufficient permissions. Please login again';
        break;
      case 'unauthenticated':
        message = 'Your session is expired Please relogin.';
        break;
      case 'not-found':
        message = 'The Document is not found.';
        break;
      case 'object-not-found':
        message = 'Could not find the file or the photo.';
        break;
      default:
        message = 'Oops! Something went wrong. Try again later.';
        break;
    }

    return message;
  }
}

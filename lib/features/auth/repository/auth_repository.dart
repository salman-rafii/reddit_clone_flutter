import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';
import 'package:reddit_clone_flutter/core/constants/firebase_constants.dart';
import 'package:reddit_clone_flutter/core/failure.dart';
import 'package:reddit_clone_flutter/core/providers/firebase_providers.dart';
import 'package:reddit_clone_flutter/core/type_defs.dart';
import 'package:reddit_clone_flutter/models/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      firestore: ref.read(firestoreProvider),
      auth: ref.read(firebaseAuthProvider),
      googleSignIn: ref.read(googleSignInProvider),
    ));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  // class constructor
  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  // create collection reference
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  // function to sign in with google
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final userData = userCredential.user!;

      UserModel userModel;
      // check if user is new or not, if new then create otherwise not
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userData.displayName ?? 'Untitled',
          profilePic: userData.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userData.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await _users.doc(userData.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userData.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}

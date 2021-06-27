import 'package:firebase_auth/firebase_auth.dart';

import '../Models/owner.dart';


class Authorization {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String activeUserId;
  Owner _createUser(User user) {
    return user == null ? null : Owner.createFromFirebase(user);
  }

  Stream<Owner> get stateFollower {
    return _firebaseAuth.authStateChanges().map(_createUser);
  }

  createUserWithMail(String email, String password) async {
    var userCard = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _createUser(userCard.user); // turns a user object
  }

  signInWithMail(String email, String password) async {
    var userCard = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _createUser(userCard.user); // turns a user object
  }

  signOut() {
    return _firebaseAuth.signOut();
  }
}

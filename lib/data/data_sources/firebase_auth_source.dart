import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/data/models/firebase_auth_user_model.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
class FirebaseAuthSource {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthUser getLoggedUser() {
    var currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      print(currentUser.email);
      return AuthUser(
        email: currentUser.email ?? '',
        password: '',
      );
    }
    return AuthUser(email: '-', password: '-');
  }

  Future<FirebaseAuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
    }) async {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
    );
    return FirebaseAuthUserModel(email: email, password: password);

  }
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
  }
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }




}
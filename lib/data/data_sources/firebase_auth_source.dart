import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/data/models/firebase_auth_user_model.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
class FirebaseAuthSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthUser? getLoggedUser() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      print("there 1");
      print(currentUser.email);
      return AuthUser(
        email: currentUser.email ?? '',
        password: '',
      );
    }
    print("there 2");
    return null;
  }

  Future<FirebaseAuthUserModel?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    if(email == null && password == null){
      print("da nu nachuj");
      var user = getLoggedUser();
      if(user != null) {
        email = user.email;
        password = user.password;
      }
    }
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
    );
    return FirebaseAuthUserModel(email: email ?? '', password: password ?? '');

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
    print("there");
    await _firebaseAuth.signOut();
  }




}
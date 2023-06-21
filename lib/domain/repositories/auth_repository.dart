import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getLoggedUser();

  Future<AuthUser?> signInWithEmailAndPassword(String? email, String? password);

  Future<void> createUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

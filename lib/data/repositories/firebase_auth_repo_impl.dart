import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthSource _dataSource;

  FirebaseAuthRepositoryImpl(this._dataSource);

  @override
  Future<AuthUser> getLoggedUser() async {
    var user = _dataSource.getLoggedUser();
    return user;
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword(String email, String password) async {
    var user = await _dataSource.signInWithEmailAndPassword(
        email: email, password: password);
    return user.toEntity();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await _dataSource.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async{
    var user = _dataSource.getLoggedUser();
    if(user.email.isNotEmpty){
      await _dataSource.signOut();
    }
  }
}

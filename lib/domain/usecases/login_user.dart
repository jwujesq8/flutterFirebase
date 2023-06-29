import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/repositories/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepository _repository;

  LoginUserUsecase(this._repository);

  Future<bool> execute(String email, String password) async {
    return await _repository.signInWithEmailAndPassword(email, password);
  }
}

import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/repositories/auth_repository.dart';

class SignOutUserUsecase {
  final AuthRepository _repository;

  SignOutUserUsecase(this._repository);

  Future<void> execute() async {
    await _repository.signOut();
  }
}

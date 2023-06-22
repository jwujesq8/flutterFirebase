import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/repositories/auth_repository.dart';

class GetLoggedUser {
  final AuthRepository _repository;
  GetLoggedUser(this._repository);

  Future<AuthUser?> execute() async {
    return await _repository.getLoggedUser();
  }
}
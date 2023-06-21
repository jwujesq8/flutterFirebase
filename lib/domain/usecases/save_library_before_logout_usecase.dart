import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/entities/book.dart';

class SaveLibraryBeforeLogout{
  final BookRepository _repository;
  SaveLibraryBeforeLogout(this._repository);

  Future<bool> execute(String userId) async{
    return await _repository.saveLibraryBeforeLogout(userId);
  }
}
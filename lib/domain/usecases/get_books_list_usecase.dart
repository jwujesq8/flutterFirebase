import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/entities/book.dart';

class GetFirstBooksList {
  final BookRepository _repository;
  GetFirstBooksList(this._repository);

  Future<List<Book>> execute(String userId) async {
    return await _repository.getFirstBooksList(userId);
  }
}
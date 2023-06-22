import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/entities/book.dart';

class RemoveBook{
  final BookRepository _repository;
  RemoveBook(this._repository);

  Future<bool> execute(Book book, String userId) async {
    return await _repository.removeBook(book, userId);
  }
}
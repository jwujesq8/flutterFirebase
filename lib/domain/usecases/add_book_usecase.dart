import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/entities/book.dart';

class AddBook{
  final BookRepository _repository;
  AddBook(this._repository);

  Future<bool> execute(Book book, String userId) async {
    return await _repository.addBook(book, userId);
  }
}
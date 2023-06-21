import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/entities/book.dart';

class UpdateBooksInfo{
  final BookRepository _repository;
  UpdateBooksInfo(this._repository);

  Future<Book> execute(Book oldBook, Book newBook, String userId) async {
    return await _repository.updateBooksInfo(oldBook, newBook, userId);
  }
}
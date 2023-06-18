import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/entities/book.dart';

class GetBooksList {
  final BookRepository _repository;
  GetBooksList(this._repository);

  Future<List<Book>> execute() async {
    return await _repository.getBooksList();
  }
}

class AddBook{
  final BookRepository _repository;
  AddBook(this._repository);

  Future<Book> execute(Book book) async {
    return await _repository.addBook(book);
  }
}

class RemoveBook{
  final BookRepository _repository;
  RemoveBook(this._repository);

  Future<int> execute(int booksId) async {
    return await _repository.removeBook(booksId);
  }
}

class UpdateBooksInfo{
  final BookRepository _repository;
  UpdateBooksInfo(this._repository);

  Future<Book> execute(int booksId) async {
    return await _repository.updateBooksInfo(booksId);
  }
}
import 'package:lsm_project/domain/entities/book.dart';

abstract class BookRepository {

  Future<List<Book>> getBooksList();

  Future<Book> addBook(Book book);

  Future<int> removeBook(int booksId);

  Future<Book> updateBooksInfo(int booksId);

}

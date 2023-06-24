import 'package:lsm_project/domain/entities/book.dart';

abstract class BookRepository {

  Future<List<Book>> getBooksList(String userId, int mode);

  Future<bool> addBook(Book book, String userId);

  Future<bool> removeBook(Book book, String userId);

  Future<Book> updateBooksInfo(Book oldBook, Book newBook, String userId);

  Future<bool> saveLibraryBeforeLogout(String userId);
}

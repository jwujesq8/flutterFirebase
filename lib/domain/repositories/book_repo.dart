import 'package:lsm_project/domain/entities/book.dart';

abstract class BookRepository {

  Future<List<Book>> getBooksList(String userId);

  Future<bool> addBook(Book book, String userId);

  Future<bool> removeBook(Book book, String userId);

  Future<Book> updateBooksInfo(Book book);

}
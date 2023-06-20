import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';

class BookRepositoryImpl extends BookRepository {
  final BookDataSource _ds;
  final GetStorage _storage = GetStorage();

  BookRepositoryImpl(this._ds);

  @override
  Future<List<Book>> getBooksList(String userId) async {
    var library = await _ds.getLibrary(userId);
    _storage.write('library$userId', library);
    return List<Book>.from(library as Iterable);
  }

  @override
  Future<bool> addBook(Book book, String userId) async {

    List<Book> library = [];
    try {
      List<Book> library = _storage.read('library$userId');
    } on Exception catch (e) {
      print("ERROR: $e");
      return false;
    }
    if (library.isEmpty) {
      List<Book> library = await getBooksList(userId);
    }
    if (library.contains(book)) {
      return false;
    } else {
      library.add(book);
      _storage.write('library$userId', library);
      //TODO: add the book to the firebase database
      return true;
    }
  }

  @override
  Future<bool> removeBook(Book book, String userId) async {
    List<Book> library = _storage.read<List<Book>>('library$userId') ?? [];
    if (!library.contains(book)) {
      return false;
    } else {
      library.remove(book);
      _storage.write('libraty$userId', library);
      //TODO: write new databsase after logout
      return true;
    }
  }

  @override
  Future<Book> updateBooksInfo(Book oldBook, Book newBook, String userId) async {
    List<Book> library = _storage.read<List<Book>>('library$userId') ?? [];
    if (!library.contains(oldBook)) {
      return Book(id: '-', title: "-", author: "-");
    } else {
      library.remove(oldBook);
      library.add(newBook);
      _storage.write('libraty$userId', library);
      //TODO: write new databsase after logout
      return newBook;
    }
  }
}

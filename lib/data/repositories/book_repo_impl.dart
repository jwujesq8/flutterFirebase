import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';

class BookRepositoryImpl extends BookRepository {
  final BookDataSource _ds;
  final GetStorage _storage = GetStorage();
  final library;

  BookRepositoryImpl(this._ds);

  @override
  Future<bool> addBook(Book book, String userId) async {
    if (){

    }
    List<Book> library = await getBooksList(userId);
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
  Future<List<Book>> getBooksList(String userId) async {
    var library = await _ds.getLibrary(userId);
    _storage.write('library$userId', library);
    return List<Book>.from(library as Iterable);
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
  Future<PublicUser> getLichessUserInfo(String nickname) async {
    var userModel = await _dataSource.getLichessUserInfo(nickname);
    return userModel.toEntity();
  }
}

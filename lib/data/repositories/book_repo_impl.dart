import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsm_project/data/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRepositoryImpl extends BookRepository {
  final BookDataSource _ds;
  final GetStorage _storage = GetStorage();

  BookRepositoryImpl(this._ds);

  @override
  Future<List<Book>> getBooksList(String userId) async {
    var library = await _ds.getLibrary(userId);
    _storage.write('library_$userId', library);
    print("LIBRARY FROM REPO_IMPPL");
    print(library);
    return library;
    //return List<Book>.from(library);
  }

  @override
  Future<bool> addBook(Book book, String userId) async {
    List<Book> library = _storage.read('library_$userId') ?? [];
    List<Book> addedBooks = _storage.read('addedBooks_$userId') ?? [];
    if (library.isEmpty) {
      library = await getBooksList(userId);
    }
    if (library.contains(book)) {
      return false;
    } else {
      library.add(book);
      _storage.write('library_$userId', library);
      if(!addedBooks.contains(book)){
        addedBooks.add(book);
        _storage.write('addedBooks_$userId', book);
      }
      return true;
    }
  }

  @override
  Future<bool> removeBook(Book book, String userId) async {
    List<Book> library = _storage.read<List<Book>>('library_$userId') ?? [];
    List<Book> removedBooks = _storage.read('removedBooks_$userId') ?? [];
    if (!library.contains(book)) {
      return false;
    } else {
      library.remove(book);
      removedBooks.add(book);
      _storage.write('library_$userId', library);
      _storage.write('removedBooks_$userId', removedBooks);
      return true;
    }
  }

  @override
  Future<Book> updateBooksInfo(Book oldBook, Book newBook, String userId) async {
    List<Book> library = _storage.read('library_$userId') ?? [];
    List<Book> removedBooks = _storage.read('removedBooks_$userId') ?? [];
    List<Book> addedBooks = _storage.read('addedBooks_$userId') ?? [];
    if (!library.contains(oldBook)) {
      return Book(id: '-', title: "-", author: "-");
    } else {
      library.remove(oldBook);
      library.add(newBook);
      _storage.write('library_$userId', library);

      removedBooks.add(oldBook);
      _storage.write('removedBooks_$userId', removedBooks);

      addedBooks.add(newBook);
      _storage.write('addedBooks_$userId', addedBooks);
      return newBook;
    }
  }

  @override
  Future<bool> saveLibraryBeforeLogout(String userId) async {
    final removedBooks = _storage.read('removedBooks_$userId') ?? [];
    final addedBooks = _storage.read('addedBooks_$userId') ?? [];
    final ref = _ds.getFirestoreCollection('library_$userId');

    for(BookModel removedBook in removedBooks){
      DocumentReference<Map<String, dynamic>> removedBookRef =
      ref.doc(removedBook.id);
      await removedBookRef.delete();
    }
    for(BookModel addedBook in addedBooks){
      await ref.add(addedBook.toJson());
    }
    return true;
  }
}

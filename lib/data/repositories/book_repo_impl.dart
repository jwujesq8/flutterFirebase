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
  Future<List<Book>> getFirstBooksList(String userId) async {

    var library = await _ds.getLibrary(userId);
    List<Book> addedBooks = [];
    List<Book> removedBooks = [];
    _storage.write('library_$userId', library);
    _storage.write('addedBooks_$userId', addedBooks);
    _storage.write('removedBooks_$userId', removedBooks);
    return library;
  }

  @override
  Future<List<Book>> getExistingBooksList(String userId) async {
    var library = _storage.read('library_$userId');
    print(library);
    return library;
  }

  @override
  Future<bool> addBook(Book book, String userId) async {
    List<Book> library = _storage.read('library_$userId');

    List<Book> addedBooks = _storage.read('addedBooks_$userId');
    // if (library.isEmpty) {
    //   library = await getBooksList(userId);
    // }
    if (library.contains(book)) {
      return false;
    } else {
      library.add(book);
      _storage.write('library_$userId', library);
      if(!addedBooks.contains(book)){
        addedBooks.add(book);
        _storage.write('addedBooks_$userId', addedBooks);
      }
      print("library:");
      print(library);
      return true;
    }
  }

  @override
  Future<bool> removeBook(Book book, String userId) async {
    List<Book> library = _storage.read('library_$userId');
    print("library from repo:");
    print(library);

    List<Book> removedBooks = _storage.read('removedBooks_$userId');
    print("removed from repo:");
    print(removedBooks);

    if (!library.contains(book)) {
      return false;
    } else {
      library.remove(book);
      print("library from repo 2:");
      print(library);

      removedBooks.add(book);
      print("removed from repo 2:");
      print(removedBooks);

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
      return Book(id: '', title: "", author: "");
    } else {
      print("before remove");
      library.remove(oldBook);
      print("before add");
      library.add(newBook);
      print("before writing library");
      _storage.write('library_$userId', library);

      print("before writing removed");
      removedBooks.add(oldBook);
      _storage.write('removedBooks_$userId', removedBooks);

      print("before adding library");
      addedBooks.add(newBook);
      _storage.write('addedBooks_$userId', addedBooks);
      return newBook;
    }
  }

  @override
  Future<bool> saveLibraryBeforeLogout(String userId) async {
    List<Book> removedBooks = _storage.read('removedBooks_$userId');
    print("REMOVED books:");
    print(removedBooks);

    List<Book> addedBooks = _storage.read('addedBooks_$userId');
    print("ADDED books:");
    print(addedBooks);

    final ref = _ds.getFirestoreCollection('library_$userId');

    try{
      for(Book removedBook in removedBooks){
        print("REMOVED BOOK:");
        print(removedBook.title);

        try {
          DocumentReference removedBookRef = ref.doc(removedBook.id);
          await removedBookRef.delete();
          print('Book removed successfully!');
        } catch (e) {
          print('Error removing book: $e');
        }
        //
        // print("REMOVED BOOK:");
        // print(removedBook.title);
        // DocumentReference removedBookRef = ref.doc(removedBook.id);
        // await removedBookRef.delete();
      }

      for(Book addedBook in addedBooks){
        print("ADDED BOOK:");
        print(addedBook.title);
        try {
          await ref.add(addedBook.toMap());
          print('Book added successfully!');
        } catch (e) {
          print('Error adding book: $e');
        }
        return true;
      }

    } catch(error){
      print(error);
    }
  return false;
  }

}

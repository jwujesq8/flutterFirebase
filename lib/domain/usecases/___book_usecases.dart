// import 'package:lsm_project/domain/repositories/book_repo.dart';
// import 'package:lsm_project/domain/entities/book.dart';
//
// class SaveLibraryBeforeLogout{
//   final BookRepository _repository;
//   SaveLibraryBeforeLogout(this._repository);
//
//   Future<bool> execute(String userId) async{
//     return await _repository.saveLibraryBeforeLogout(userId);
//   }
// }

//class GetBooksList {
//   final BookRepository _repository;
//   GetBooksList(this._repository);
//
//   Future<List<Book>> execute(String userId) async {
//     return await _repository.getBooksList(userId);
//   }
// }
//
// class AddBook{
//   final BookRepository _repository;
//   AddBook(this._repository);
//
//   Future<bool> execute(Book book, String userId) async {
//     return await _repository.addBook(book, userId);
//   }
// }
//class RemoveBook{
//   final BookRepository _repository;
//   RemoveBook(this._repository);
//
//   Future<bool> execute(Book book, String userId) async {
//     return await _repository.removeBook(book, userId);
//   }
// }
//class UpdateBooksInfo{
//   final BookRepository _repository;
//   UpdateBooksInfo(this._repository);
//
//   Future<Book> execute(Book oldBook, Book newBook, String userId) async {
//     return await _repository.updateBooksInfo(oldBook, newBook, userId);
//   }
// }
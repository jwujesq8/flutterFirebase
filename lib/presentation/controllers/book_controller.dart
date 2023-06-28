import 'package:get/get.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/usecases/getExistingBooksList.dart';
import 'package:lsm_project/domain/usecases/login_user.dart';
import 'package:lsm_project/domain/usecases/get_books_list_usecase.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/usecases/sign_out_user_usecase.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../domain/usecases/add_book_usecase.dart';
import '../../domain/usecases/remove_book_usecase.dart';
import '../../domain/usecases/save_library_before_logout_usecase.dart';
import '../../domain/usecases/update_books_info_usecase.dart';
import '../pages/auth/auth_controller.dart';

class BookController extends GetxController {
  AddBook addBook;
  GetExistingBooksList getExistingBooksList;
  GetLoggedUser getLoggedUser;
  LoginUserUsecase loginUserUsecase;
  RemoveBook removeBook;
  SaveLibraryBeforeLogout saveLibraryBeforeLogout;
  SignOutUserUsecase signOutUserUsecase;
  UpdateBooksInfo updateBooksInfo;

  BookController({
    required this.addBook,
    required this.getExistingBooksList,
    required this.getLoggedUser,
    required this.loginUserUsecase,
    required this.removeBook,
    required this.saveLibraryBeforeLogout,
    required this.signOutUserUsecase,
    required this.updateBooksInfo
  });


  final RxList<Book> _list = <Book>[].obs;

  //AuthUser? get user => _user.value;

  @override
  void onInit() async {
    super.onInit();
    var user = await getLoggedUser.execute();
    _list.value = await getExistingBooksList.execute(user.email);
    }

    @override
    void onClose() async{
    super.onClose();

    }



  Future<bool> addBookToLibrary(Book book, String userId) async {
    if(userId.isNotEmpty){
      bool answer = await addBook.execute(book, userId);
      if(answer){
        return true;
      }
    }
    return false;
  }
  Future<List<Book>> getExistingLibrary(String userId) async {
    if(userId.isNotEmpty){
      _list.value = await getExistingBooksList.execute(userId);
      return _list.value;
    }
    return [];
  }
  Future<AuthUser> getLoggedUsername() async {
    return await getLoggedUser.execute();
  }
  Future<AuthUser> loginUser(String email, String password) async {
    if(email.isNotEmpty && password.isNotEmpty){
      var user = await loginUserUsecase.execute(email, password);
      return user;
    }
    else{
      return AuthUser(email: '', password: '');
    }
  }
  Future<bool> removeBookFromLibrary(Book book, String userId) async {
    if(book.title.isNotEmpty && userId.isNotEmpty){
      await removeBook.execute(book, userId);
      //_list.remove(book);
      return true;
    } else{
      return false;
    }
  }
  Future<bool> saveChangesBeforeLogout(String userId) async {
    bool answer = await saveLibraryBeforeLogout.execute(userId);
    return answer;
  }
  Future<bool> logOut() async {
    var user = await getLoggedUsername();
    if(user.email.isNotEmpty){
      await saveLibraryBeforeLogout.execute(user.email);
      await signOutUserUsecase.execute();
      return true;
    }
    return false;
  }
  Future<Book> updateBook(Book oldBook, Book newBook, String userId) async {
    if(userId.isNotEmpty){
      await updateBooksInfo.execute(oldBook, newBook, userId);
      // _list.remove(oldBook);
      // _list.add(newBook);
      return newBook;
    }
    else {
      return Book(id: '', title: "", author: "");
    }
}
}

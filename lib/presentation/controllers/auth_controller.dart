import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/entities/quote.dart';
import 'package:lsm_project/domain/usecases/login_user.dart';
import 'package:lsm_project/domain/usecases/get_books_list_usecase.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/usecases/sign_out_user_usecase.dart';

import '../../domain/usecases/get_first_quotes_list.dart';
import '../../domain/usecases/get_logged_user.dart';

class AuthController extends GetxController {
  LoginUserUsecase loginUserUsecase;
  SignOutUserUsecase signOutUserUsecase;
  GetLoggedUser getLoggedUser;
  GetFirstBooksList getFirstBooksList;
  GetFirstQuotesList getFirstQuotesList;

  AuthController({
    required this.loginUserUsecase,
    required this.signOutUserUsecase,
    required this.getFirstBooksList,
    required this.getLoggedUser,
    required this.getFirstQuotesList
  });

  final RxList<Book> _books = <Book>[].obs;
  final RxList<Quote> _quotes = <Quote>[].obs;


  Future<void> getFirstBooks() async {
    var userId = await getUserId();
    _books.value = await getFirstBooksList.execute(userId);
  }
  Future<void> getFirstQuotes() async {
    var userId = await getUserId();
    _quotes.value = await getFirstQuotesList.execute(userId);
  }
  @override
  Future<void> onInit() async {
    await getFirstBooks();
    await getFirstQuotes();
    super.onInit();
  }
  Future<String> getUserId() async {
    var user = await getLoggedUser.execute();
    return user.email;
  }

  void signOut() async {
    await signOutUserUsecase.execute();
  }

  Future<bool> signIn(String email, String password) async {
    return await loginUserUsecase.execute(email, password);

  }

}

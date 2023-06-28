import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/data/data_sources/quotes_ds.dart';
import 'package:lsm_project/data/repositories/book_repo_impl.dart';
import 'package:lsm_project/data/repositories/quote_repo_impl.dart';
import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:get/get.dart';
import 'package:lsm_project/domain/repositories/quote_repo.dart';
import 'package:lsm_project/presentation/pages/auth/auth_controller.dart';

import '../../data/data_sources/firebase_auth_source.dart';
import '../../data/repositories/firebase_auth_repo_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_books_list_usecase.dart';
import '../../domain/usecases/get_existing_quotes_list.dart';
import '../../domain/usecases/get_first_quotes_list.dart';
import '../../domain/usecases/get_logged_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/sign_out_user_usecase.dart';
import '../../presentation/controllers/quote_controller.dart';

class DependencyCreator {
  /// Initialize all dependencies
  static init() {
    Get.lazyPut<FirebaseAuthSource>(() => FirebaseAuthSource());
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepositoryImpl(Get.find()));
    Get.lazyPut<BookDataSource>(() => BookDataSource());
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
    Get.lazyPut<QuoteDataSource>(() => QuoteDataSource());
    Get.lazyPut<QuoteRepository>(() => QuoteRepositoryImpl(Get.find()));
    Get.lazyPut(() => AuthController(
        loginUserUsecase: Get.put(LoginUserUsecase(Get.find())),
        getFirstBooksList: Get.put(GetFirstBooksList(Get.find())),
        signOutUserUsecase: Get.put(SignOutUserUsecase(Get.find())),
        getLoggedUser: Get.put(GetLoggedUser(Get.find())),
      getFirstQuotesList: Get.put(GetFirstQuotesList(Get.find()))
    ));
    Get.lazyPut(() => QuoteController(
        getLoggedUser: Get.put(GetLoggedUser(Get.find())),
        getExistingQuotesList: Get.put(GetExistingQuotesList(Get.find())),
        getFirstQuotesList: Get.put(GetFirstQuotesList(Get.find()))
    ));
  }
}

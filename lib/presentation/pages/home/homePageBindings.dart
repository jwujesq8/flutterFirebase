import 'package:get/get.dart';
import 'package:lsm_project/presentation/controllers/auth_controller.dart';

import '../../../data/data_sources/book_ds.dart';
import '../../../data/data_sources/firebase_auth_source.dart';
import '../../../data/data_sources/quotes_ds.dart';
import '../../../data/repositories/book_repo_impl.dart';
import '../../../data/repositories/firebase_auth_repo_impl.dart';
import '../../../data/repositories/quote_repo_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/book_repo.dart';
import '../../../domain/repositories/quote_repo.dart';
import '../../../domain/usecases/get_books_list_usecase.dart';
import '../../../domain/usecases/get_existing_quotes_list.dart';
import '../../../domain/usecases/get_first_quotes_list.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../../controllers/quote_controller.dart';

class HomePageBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(
    //   AuthController(
    //       loginUserUsecase: Get.put(LoginUserUsecase(Get.find())),
    //       getFirstBooksList: Get.put(GetFirstBooksList(Get.find())),
    //       signOutUserUsecase: Get.put(SignOutUserUsecase(Get.find())),
    //       getLoggedUser: Get.put(GetLoggedUser(Get.find())),
    //       getFirstQuotesList: Get.put(GetFirstQuotesList(Get.find()))
    //   ),);
    Get.lazyPut<FirebaseAuthSource>(() => FirebaseAuthSource());
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepositoryImpl(Get.find()));
    Get.lazyPut<BookDataSource>(() => BookDataSource());
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
    Get.lazyPut<QuoteDataSource>(() => QuoteDataSource());
    Get.lazyPut<QuoteRepository>(() => QuoteRepositoryImpl(Get.find()));
    Get.put(GetLoggedUser(Get.find()));
    Get.put(GetExistingQuotesList(Get.find()));

    Get.put<QuoteController>(
      QuoteController(
        getLoggedUser: Get.find(),
        getExistingQuotesList: Get.find()
    ));
  }
}
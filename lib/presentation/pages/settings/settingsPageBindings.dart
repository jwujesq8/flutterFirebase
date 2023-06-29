import 'package:get/get.dart';
import 'package:lsm_project/domain/usecases/save_library_before_logout_usecase.dart';
import 'package:lsm_project/presentation/controllers/settings_controller.dart';

import '../../../data/data_sources/book_ds.dart';
import '../../../data/data_sources/quotes_ds.dart';
import '../../../data/repositories/book_repo_impl.dart';
import '../../../data/repositories/quote_repo_impl.dart';
import '../../../domain/repositories/book_repo.dart';
import '../../../domain/repositories/quote_repo.dart';
import '../../../domain/usecases/get_books_list_usecase.dart';
import '../../../domain/usecases/get_first_quotes_list.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../../controllers/auth_controller.dart';

class SettingsPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteDataSource>(() => QuoteDataSource());
    Get.lazyPut<QuoteRepository>(() => QuoteRepositoryImpl(Get.find()));
    Get.lazyPut<BookDataSource>(() => BookDataSource());
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
    Get.put(LoginUserUsecase(Get.find()));
    Get.put(GetFirstBooksList(Get.find()));
    Get.put(SignOutUserUsecase(Get.find()));
    Get.put(GetLoggedUser(Get.find()));
    Get.put(GetFirstQuotesList(Get.find()));
    Get.put<SettingsController>(SettingsController(
        saveLibraryBeforeLogout: Get.put(SaveLibraryBeforeLogout(Get.find()))
    ));
    Get.put<AuthController>(AuthController(
        loginUserUsecase: Get.find(),
        getFirstBooksList: Get.find(),
        signOutUserUsecase: Get.find(),
        getLoggedUser: Get.find(),
        getFirstQuotesList: Get.find()
    ));
  }
}
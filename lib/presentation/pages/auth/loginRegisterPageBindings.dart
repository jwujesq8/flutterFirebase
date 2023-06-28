import 'package:lsm_project/domain/usecases/add_book_usecase.dart';
import 'package:lsm_project/domain/usecases/getExistingBooksList.dart';
import 'package:lsm_project/domain/usecases/get_books_list_usecase.dart';
import 'package:lsm_project/domain/usecases/get_existing_quotes_list.dart';
import 'package:lsm_project/domain/usecases/get_first_quotes_list.dart';
import 'package:lsm_project/domain/usecases/get_logged_user.dart';
import 'package:lsm_project/domain/usecases/login_user.dart';
import 'package:lsm_project/domain/usecases/remove_book_usecase.dart';
import 'package:lsm_project/domain/usecases/save_library_before_logout_usecase.dart';
import 'package:lsm_project/domain/usecases/update_books_info_usecase.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/controllers/quote_controller.dart';
import 'package:lsm_project/presentation/pages/auth/auth_controller.dart';

import '../../../domain/usecases/sign_out_user_usecase.dart';


class LoginRegisterPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AddBook(Get.find()));
    Get.put(RemoveBook(Get.find()));
    Get.put(GetFirstBooksList(Get.find()));
    Get.put(UpdateBooksInfo(Get.find()));
    Get.put(SaveLibraryBeforeLogout(Get.find()));
    Get.put(LoginUserUsecase(Get.find()));
    //Get.put(GetBooksList(Get.find()));
    Get.put(SignOutUserUsecase(Get.find()));
    Get.put(GetLoggedUser(Get.find()));
    Get.put<AuthController>(AuthController(
        loginUserUsecase: Get.find(),
        getFirstBooksList: Get.find(),
        signOutUserUsecase: Get.find(),
        getLoggedUser: Get.find()
    ));
    Get.put(GetExistingQuotesList(Get.find()));
    Get.put(GetFirstQuotesList(Get.find()));
    Get.put<QuoteController>(QuoteController(
        getLoggedUser: Get.find(),
        getExistingQuotesList: Get.find(),
        getFirstQuotesList: Get.find()
    ));

  }
}

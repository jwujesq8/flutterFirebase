import 'package:get/get.dart';
import 'package:lsm_project/presentation/controllers/auth_controller.dart';

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

    Get.put(GetLoggedUser(Get.find()));
    Get.put(GetExistingQuotesList(Get.find()));

    Get.put<QuoteController>(
      QuoteController(
        getLoggedUser: Get.find(),
        getExistingQuotesList: Get.find()
    ));
  }
}
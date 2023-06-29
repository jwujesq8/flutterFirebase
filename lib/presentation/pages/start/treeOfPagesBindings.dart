import 'package:get/get.dart';

import '../../../domain/usecases/get_books_list_usecase.dart';
import '../../../domain/usecases/get_first_quotes_list.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../../controllers/auth_controller.dart';

class TreeOfPagesBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginUserUsecase(Get.find()));
    Get.put(GetFirstBooksList(Get.find()));
    Get.put(SignOutUserUsecase(Get.find()));
    Get.put(GetLoggedUser(Get.find()));
    Get.put(GetFirstQuotesList(Get.find()));
    Get.put<AuthController>(AuthController(
        loginUserUsecase: Get.find(),
        getFirstBooksList: Get.find(),
        signOutUserUsecase: Get.find(),
        getLoggedUser: Get.find(),
        getFirstQuotesList: Get.find()
    ),);
  }
}
import 'package:get/get.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';

import '../../../domain/usecases/get_books_list_usecase.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../auth/auth_controller.dart';

class LibraryPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AuthController(
          loginUserUsecase: Get.put(LoginUserUsecase(Get.find())),
          getBooksList: Get.put(GetBooksList(Get.find())),
          signOutUserUsecase: Get.put(SignOutUserUsecase(Get.find())),
          getLoggedUser: Get.put(GetLoggedUser(Get.find()))
      ),);
  }
}
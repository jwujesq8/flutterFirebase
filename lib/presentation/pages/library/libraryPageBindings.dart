import 'package:get/get.dart';
import 'package:lsm_project/domain/usecases/getExistingBooksList.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';

import '../../../domain/usecases/add_book_usecase.dart';
import '../../../domain/usecases/get_books_list_usecase.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/remove_book_usecase.dart';
import '../../../domain/usecases/save_library_before_logout_usecase.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../../../domain/usecases/update_books_info_usecase.dart';
import '../auth/auth_controller.dart';

class LibraryPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginUserUsecase(Get.find()));
    Get.put(GetExistingBooksList(Get.find()));
    Get.put(SignOutUserUsecase(Get.find()));
    Get.put(GetLoggedUser(Get.find()));
    Get.put(AuthController(
          loginUserUsecase: Get.put(Get.find()),
          getFirstBooksList: Get.put(Get.find()),
          signOutUserUsecase: Get.put(Get.find()),
          getLoggedUser: Get.put(Get.find())
      ),);
    Get.put(BookController(
        addBook: Get.put(AddBook(Get.find())),
        getExistingBooksList: Get.put(Get.find()),
        getLoggedUser: Get.put(Get.find()),
        loginUserUsecase: Get.put(Get.find()),
        removeBook: Get.put(RemoveBook(Get.find())),
        saveLibraryBeforeLogout: Get.put(SaveLibraryBeforeLogout(Get.find())),
        signOutUserUsecase: Get.put(Get.find()),
        updateBooksInfo: Get.put(UpdateBooksInfo(Get.find()))
      ));

  }
}
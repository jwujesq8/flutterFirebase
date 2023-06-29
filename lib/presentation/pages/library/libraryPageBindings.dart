import 'package:get/get.dart';
import 'package:lsm_project/domain/usecases/getExistingBooksList.dart';
import 'package:lsm_project/domain/usecases/get_first_quotes_list.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';

import '../../../data/data_sources/book_ds.dart';
import '../../../data/data_sources/firebase_auth_source.dart';
import '../../../data/data_sources/quotes_ds.dart';
import '../../../data/repositories/book_repo_impl.dart';
import '../../../data/repositories/firebase_auth_repo_impl.dart';
import '../../../data/repositories/quote_repo_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/book_repo.dart';
import '../../../domain/repositories/quote_repo.dart';
import '../../../domain/usecases/add_book_usecase.dart';
import '../../../domain/usecases/get_books_list_usecase.dart';
import '../../../domain/usecases/get_logged_user.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/remove_book_usecase.dart';
import '../../../domain/usecases/save_library_before_logout_usecase.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../../../domain/usecases/update_books_info_usecase.dart';
import '../../controllers/auth_controller.dart';

class LibraryPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthSource>(() => FirebaseAuthSource());
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepositoryImpl(Get.find()));
    Get.lazyPut<BookDataSource>(() => BookDataSource());
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
        Get.put(BookController(
          addBook: Get.put(AddBook(Get.find())),
          getExistingBooksList: Get.put(GetExistingBooksList(Get.find())),
          getLoggedUser: Get.put(GetLoggedUser(Get.find())),
          removeBook: Get.put(RemoveBook(Get.find())),
          saveLibraryBeforeLogout: Get.put(SaveLibraryBeforeLogout(Get.find())),
          updateBooksInfo: Get.put(UpdateBooksInfo(Get.find()))
      ));

  }
}
import 'package:lsm_project/data/data_sources/book_ds.dart';
import 'package:lsm_project/data/repositories/book_repo_impl.dart';
import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:get/get.dart';

import '../../data/data_sources/firebase_auth_source.dart';
import '../../data/repositories/firebase_auth_repo_impl.dart';
import '../../domain/repositories/auth_repository.dart';

class DependencyCreator {
  /// Initialize all dependencies
  static init() {
    Get.lazyPut<FirebaseAuthSource>(() => FirebaseAuthSource());
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepositoryImpl(Get.find()));
    Get.lazyPut<BookDataSource>(() => BookDataSource());
    Get.lazyPut<BookRepository>(() => BookRepositoryImpl(Get.find()));
  }
}

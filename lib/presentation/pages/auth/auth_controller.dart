import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/usecases/login_user.dart';
import 'package:lsm_project/domain/usecases/get_books_list_usecase.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/usecases/sign_out_user_usecase.dart';

class AuthController extends GetxController {
  LoginUserUsecase loginUserUsecase;
  SignOutUserUsecase signOutUserUsecase;
  GetBooksList getBooksList;

  AuthController({
    required this.loginUserUsecase,
    required this.signOutUserUsecase,
    required this.getBooksList,
  });

  final Rx<AuthUser?> _user = Rx<AuthUser?>(null);
  final RxList<Book?> _list = <Book?>[].obs;

  AuthUser? get user => _user.value;

  @override
  void onInit() async {
    super.onInit();
    _user.value =
    await loginUserUsecase.execute(_user.value?.email, _user.value?.password);
    _list.value = await getBooksList.execute(_user.value?.email ?? '');
  }

  @override
  void onClose() async {
    super.onClose();
    await signOutUserUsecase.execute();
    _user.close();
    _list.close();
  }
}

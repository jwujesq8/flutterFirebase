import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/usecases/login_user.dart';
import 'package:lsm_project/domain/usecases/get_books_list_usecase.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/usecases/sign_out_user_usecase.dart';

import '../../../domain/usecases/get_logged_user.dart';

class AuthController extends GetxController {
  LoginUserUsecase loginUserUsecase;
  SignOutUserUsecase signOutUserUsecase;
  GetLoggedUser getLoggedUser;
  GetFirstBooksList getFirstBooksList;

  AuthController({
    required this.loginUserUsecase,
    required this.signOutUserUsecase,
    required this.getFirstBooksList,
    required this.getLoggedUser
  });

  final Rx<AuthUser> _user = AuthUser(email: '', password: '').obs;
  final RxList<Book> _list = <Book>[].obs;

  AuthUser? get user => _user.value;
  @override
  void onClose() async {
    super.onClose();
    await signOutUserUsecase.execute();
    // _user.close();
    // _list.close();
  }

  @override
  void onInit() async {
    super.onInit();
    var user = await getLoggedUser.execute();
    if(user.email.isNotEmpty){
      _user.value = AuthUser(email: user.email, password: user.password);
      _list.value = await getFirstBooksList.execute(_user.value.email);
    }
    // else {
    //   onClose();
    // }
  }

  void signOut() async {
    _user.value.email = '';
    _user.value.password = '';
    _list.value = [];
    onClose();
    await signOutUserUsecase.execute();
  }

  Future<bool> signIn(String email, String password) async {
    var user = await loginUserUsecase.execute(email, password);
    _user.value.email = user.email;
    _user.value.password = user.password;
     if(_user.value.email.isNotEmpty){
       return true;
     } else {
       return false;
     }
  }



}

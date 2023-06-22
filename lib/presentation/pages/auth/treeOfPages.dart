import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/usecases/get_logged_user.dart';
import 'package:lsm_project/presentation/pages/home/homePage.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPage.dart';
import '../../../domain/usecases/get_books_list_usecase.dart';
import 'package:flutter/material.dart';
import '../../../domain/usecases/sign_out_user_usecase.dart';
import '../../../domain/usecases/login_user.dart';
import 'auth_controller.dart';
import 'package:get/get.dart';

class TreeOfPages extends StatefulWidget {
  const TreeOfPages({Key? key}) : super(key: key);

  @override
  State<TreeOfPages> createState() => _TreeOfPagesState();
}

class _TreeOfPagesState extends State<TreeOfPages> {
  final _authController = Get.put(
      AuthController(
        loginUserUsecase: Get.put(LoginUserUsecase(Get.find())),
        getBooksList: Get.put(GetBooksList(Get.find())),
        signOutUserUsecase: Get.put(SignOutUserUsecase(Get.find())),
        getLoggedUser: Get.put(GetLoggedUser(Get.find()))
      ),);// Initialize AuthController using Get.put

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthSource().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

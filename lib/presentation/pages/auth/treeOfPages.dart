import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
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
  final AuthController _authController = Get.find<AuthController>();// Initialize AuthController using Get.put
  final FirebaseAuthSource dataSource = FirebaseAuthSource();


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = _authController.user;
      if (user != null && user.email.isNotEmpty) {
        print(user.email);
        return HomePage();
      } else {
        return LoginPage();
      }
    });
  }



}

import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/data/data_sources/quotes_ds.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/entities/quote.dart';
import 'package:lsm_project/domain/usecases/get_logged_user.dart';
import 'package:lsm_project/presentation/controllers/quote_controller.dart';
import 'package:lsm_project/presentation/pages/home/homePage.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPage.dart';
import '../../../domain/entities/book.dart';
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
  final FirebaseAuthSource dataSource = FirebaseAuthSource();
  final QuoteDataSource quoteDataSource = QuoteDataSource();
  final AuthController _authController = Get.find<AuthController>();// Initialize AuthController using Get.put
  final QuoteController _quoteController = Get.find<QuoteController>();



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = _authController.user;
      if (user != null && user.email.isNotEmpty) {
        _authController.getFirstBooksList.execute(user.email);
        _authController.getFirstQuotesList.execute(user.email);
        //_quoteController.getStartQuotesList(user.email);
        return HomePage();
      } else {
        return LoginPage();
      }
    });
  }



}

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/domain/entities/quote.dart';
import 'package:lsm_project/domain/usecases/login_user.dart';
import 'package:lsm_project/domain/usecases/get_books_list_usecase.dart';
import 'package:lsm_project/domain/entities/book.dart';
import 'package:lsm_project/domain/usecases/save_library_before_logout_usecase.dart';
import 'package:lsm_project/domain/usecases/sign_out_user_usecase.dart';
import 'package:lsm_project/presentation/controllers/auth_controller.dart';

import '../../domain/usecases/get_first_quotes_list.dart';
import '../../domain/usecases/get_logged_user.dart';

class SettingsController extends GetxController {
  SaveLibraryBeforeLogout saveLibraryBeforeLogout;

  SettingsController({
    required this.saveLibraryBeforeLogout
  });

  Future<bool> saveAll(String userId) async {
    bool answer = await saveLibraryBeforeLogout.execute(userId);
    return answer;
  }




}

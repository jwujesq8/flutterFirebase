import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPage.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPageBindings.dart';
import 'package:lsm_project/presentation/pages/home/homePage.dart';
import 'package:lsm_project/presentation/pages/home/homePageBindings.dart';
import 'package:lsm_project/presentation/pages/library/libraryPage.dart';
import 'package:lsm_project/presentation/pages/library/libraryPageBindings.dart';

import '../../presentation/pages/settings/settingsPage.dart';


List<GetPage<dynamic>> get Routing{
  return [

      GetPage(
        name: '/login',
        page: () => const LoginPage(),
        transition: Transition.fadeIn,
        binding: LoginRegisterPageBindings(),
      ),
      GetPage(
        name: '/home',
        page: () => HomePage(),
        transition: Transition.fadeIn,
        binding: LoginRegisterPageBindings(),
      ),
      GetPage(
        name: '/library',
        page: () => LibraryPage(),
        transition: Transition.fadeIn,
        binding: LibraryPageBindings(),
      ),
    GetPage(
      name: '/settings',
      page: () => SettingsPage(),
      transition: Transition.fadeIn,
    ),
    //GetPage(name: name, page: page)
  ];
}
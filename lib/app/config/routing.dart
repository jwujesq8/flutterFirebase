import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPage.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPageBindings.dart';
import 'package:lsm_project/presentation/pages/start/treeOfPages.dart';
import 'package:lsm_project/presentation/pages/home/homePage.dart';
import 'package:lsm_project/presentation/pages/home/homePageBindings.dart';
import 'package:lsm_project/presentation/pages/library/editLibrary/editCurrentBook/editCurrentBookPage.dart';
import 'package:lsm_project/presentation/pages/library/libraryPage.dart';
import 'package:lsm_project/presentation/pages/library/libraryPageBindings.dart';

import '../../presentation/pages/library/editLibrary/addNewBookPage.dart';
import '../../presentation/pages/library/editLibrary/editLibrary.dart';
import '../../presentation/pages/library/editLibrary/___editLibraryBindings.dart';
import '../../presentation/pages/settings/settingsPage.dart';
import '../../presentation/pages/settings/settingsPageBindings.dart';
import '../../presentation/pages/start/treeOfPagesBindings.dart';


List<GetPage<dynamic>> get Routing{
  return [
    GetPage(
      name: '/recognize',
      page: () => const TreeOfPages(),
      //transition: Transition.fadeIn,
      binding: TreeOfPagesBindings(),
    ),


    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      //transition: Transition.fadeIn,
      binding: LoginRegisterPageBindings(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      //transition: Transition.fadeIn,
      binding: HomePageBindings(),
    ),
    GetPage(
      name: '/library',
      page: () => LibraryPage(),
      //transition: Transition.fadeIn,
      binding: LibraryPageBindings(),
    ),
    GetPage(
      name: '/editLibrary',
      page: () => EditLibraryPage(),
      //transition: Transition.fadeIn,
      binding: LibraryPageBindings(),
    ),

    GetPage(
      name: '/addNewBook',
      page: () => AddNewBookPage(),
      //transition: Transition.fadeIn,
      binding: LibraryPageBindings(),
    ),
    
      GetPage(
        name: '/settings',
        page: () => const SettingsPage(),
        //transition: Transition.fadeIn,
        binding: SettingsPageBindings(),
      ),

    //GetPage(name: name, page: page)
  ];
}
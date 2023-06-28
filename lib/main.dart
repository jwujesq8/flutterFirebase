import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lsm_project/presentation/pages/auth/loginRegisterPage.dart';
import 'package:lsm_project/presentation/pages/auth/treeOfPages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsm_project/app/config/routing.dart' as App;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'app/util/dependency_creator.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  DependencyCreator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.primaries[16]),
        fontFamily: 'Ysabeau'
      ),
      initialRoute: '/',
      defaultTransition: Transition.fadeIn,
      getPages: App.Routing,
      home: TreeOfPages(),
    );
  }
}

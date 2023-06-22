import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';
import 'package:lsm_project/presentation/pages/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/navigation_bar/custom_navigation_bar.dart';

import '../../../domain/entities/auth_user.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);
  //final HomeAppController bottomBarController = Get.find();
  final _authController = Get.find<AuthController>();
  //final User? user = FirebaseAuthSource().currentUser;

  Future<void> signOut() async {
    await _authController.signOutUserUsecase.execute();
  }
  Future<Widget> userId() async{
    var user = await _authController.getLoggedUser.execute();
    if (user != null){
      return Text(user.email);
    } else {
      return const Text("oops...");
    }
    //return Text(user?.email ?? 'user email');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase auth'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         signOut();
        //       },
        //       icon: const Icon(Icons.logout))
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Widget>(
              future: userId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data ?? const Text('Oops...');
                }
              },
            ),
          ],
          // children: [
          //   userId(),
          // ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),

    );
  }

}

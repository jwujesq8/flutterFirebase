import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';

import '../auth/auth_controller.dart';
import '../navigation_bar/custom_navigation_bar.dart';

class LibraryPage extends StatelessWidget{
  LibraryPage({Key? key}) : super(key: key);
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
        title: const Text('library'),
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
            const Text('some books later..'),
            const Text('your login: '),
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
          ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
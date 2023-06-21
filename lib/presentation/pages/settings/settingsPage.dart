import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/navigation_bar/custom_navigation_bar.dart';

class SettingsPage extends StatelessWidget{
  SettingsPage({Key? key}) : super(key: key);
  //final HomeAppController bottomBarController = Get.find();

  final User? user = FirebaseAuthSource().currentUser;

  Future<void> signOut() async {
    await FirebaseAuthSource().signOut();
  }
  Widget userId(){
    return Text(user?.email ?? 'user email');
  }
  Widget signOutButton(){
    return ElevatedButton(
        onPressed: signOut,
        child: const Text('sign out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userId(),
            signOutButton()
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),

    );
  }

}

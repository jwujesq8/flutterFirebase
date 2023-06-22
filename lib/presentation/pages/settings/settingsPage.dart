import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/navigation_bar/custom_navigation_bar.dart';

import '../auth/auth_controller.dart';
import '../auth/loginRegisterPage.dart';
import '../auth/treeOfPages.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({Key? key}) : super (key:key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  //final HomeAppController bottomBarController = Get.find();

  //final User? user = FirebaseAuthSource().currentUser;
  final _authController = Get.find<AuthController>();
  final RxBool isLogin = true.obs;
  RxBool changePage = false.obs;

  Future<void> signOut() async {
    _authController.signOut();
  }
  Future<void> goToLoginPage() async{
    Get.to(const TreeOfPages());
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
  // Widget switchButtonForLogOut() {
  //   return TextButton(
  //       onPressed: (){
  //         setState((){
  //           changePage = !changePage;
  //         });
  //       },
  //       child: Text(changePage ? 'go to Login Page': 'logOut')
  //     );
  // }
  Widget signOutButton(){
    return ElevatedButton(
        onPressed:() async{
          signOut;
          Get.to(() => const TreeOfPages());
        },
        child: const Text('sign out'),
    );
  }
  Widget switchedButtonForLogOut(){
    return ElevatedButton(
        onPressed: () {
          if(changePage.value == true){
            print("inside changePage == true");
            goToLoginPage();
          } else {
            signOut();
          }
          print(changePage.value);
          changePage.value = !changePage.value;
        },
        child: Text (changePage.value==true ? 'go to Login Page' : 'log out')
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
            switchedButtonForLogOut(),

          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),

    );
  }

}

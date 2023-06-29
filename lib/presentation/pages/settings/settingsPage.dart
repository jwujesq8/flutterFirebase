import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/controllers/quote_controller.dart';
import 'package:lsm_project/presentation/pages/navigation_bar/custom_navigation_bar.dart';

import '../../controllers/auth_controller.dart';
import '../auth/loginRegisterPage.dart';
import '../start/treeOfPages.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({Key? key}) : super (key:key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  //final HomeAppController bottomBarController = Get.find();

  //final User? user = FirebaseAuthSource().currentUser;
  final _authController = Get.find<AuthController>();
  //final _bookController = Get.find<BookController>();
  final RxBool isLogin = true.obs;
  RxBool changePage = false.obs;

  Future<void> signOut() async {
    _authController.signOut();
  }
  Future<void> goToLoginPage() async{
    Get.to(const TreeOfPages());
    //Get.offAllNamed('/recognize');
  }
  Future<Widget> userId() async{
    var userId = await _authController.getUserId();
    if (userId.isNotEmpty){
      return Center(
        child: Text(userId, style: const TextStyle(
          fontSize: 20
        ),),
      );
    } else {
      return const Text("oops...");
    }
  }
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
    return Obx(() => ElevatedButton(
      onPressed: () {
        if(changePage.value == true){
          goToLoginPage();
        } else {
          signOut();
        }
        changePage.toggle();
      },
      child: Text(changePage.value ? 'go back' : 'log out'),
    ));
  }
  // Future<void> saveAll() async{
  //   var user = await _authController.getLoggedUser.execute();
  //   bool answer = await _bookController.saveChangesBeforeLogout(user.email);
  //   print(answer);
  // }

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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(
              height: 80,
            ),
            // ElevatedButton(
            //     onPressed: saveAll,
            //     child: Text("save changes", style: TextStyle(fontSize: 20),)),
            switchedButtonForLogOut(),

          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),

    );
  }

}

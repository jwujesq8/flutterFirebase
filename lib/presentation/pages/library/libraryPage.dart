import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';

import '../navigation_bar/custom_navigation_bar.dart';

class LibraryPage extends StatelessWidget{
  LibraryPage({Key? key}) : super(key: key);

  final User? user = FirebaseAuthSource().currentUser;
  Future<void> signOut() async {
    await FirebaseAuthSource().signOut();
  }
  Widget userId(){
    return Text(user?.email ?? 'user email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('library'),
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
            const Text('some books later..'),
            const Text('your login: '),
            userId()
          ]

        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),


    );
  }

}
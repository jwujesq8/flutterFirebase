import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';

import '../../../domain/entities/book.dart';
import '../auth/auth_controller.dart';
import '../navigation_bar/custom_navigation_bar.dart';

class LibraryPage extends StatelessWidget{
  LibraryPage({Key? key}) : super(key: key);
  final _authController = Get.find<AuthController>();

  List<Book> books = [
    Book(id: '0', title: "Demons", author: "Fyodor Dostoevsky", pages: 648,
      read: true, like: true, opinion: "I want to read it again)"),
    Book(id: '1', title: "Demons", author: "Fyodor Dostoevsky", pages: 648,
        read: true, like: true, opinion: "I want to read it again)"),
    Book(id: '2', title: "Demons", author: "Fyodor Dostoevsky", pages: 648,
        read: true, like: true, opinion: "I want to read it again)"),
    Book(id: '3', title: "Demons", author: "Fyodor Dostoevsky", pages: 648,
        read: true, like: true, opinion: "I want to read it again)"),
    Book(id: '4', title: "Demons", author: "Fyodor Dostoevsky", pages: 648,
        read: true, like: true, opinion: "I want to read it again)"),
  ];

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

  Widget createBooksCard(Book book) {
    return Card(
        child: Column(
          children: [
            Container(
              child: Text(
                book.title.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3b2a2f),
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              child: Text(
                book.author.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff543c43),
                  fontSize: 11,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "pages: ${book.pages}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff543c43),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "read: ${book.read}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff543c43),
                      fontSize: 11,
                    ),
                  ),
                ],
              )
            )
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('library'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text('your login: '),
            //FutureBuilder<Widget>(
            //   future: userId(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       return snapshot.data ?? const Text('Oops...');
            //     }
            //   },
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return createBooksCard(books[index]);
                },
              ),
            ),
          ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
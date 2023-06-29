import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';

import '../../../domain/entities/book.dart';
import '../../controllers/auth_controller.dart';
import '../navigation_bar/custom_navigation_bar.dart';

class LibraryPage extends StatelessWidget{
  LibraryPage({Key? key}) : super(key: key);
  final _bookController = Get.find<BookController>();
  RxInt booksLength = 0.obs;
  RxList<Book> books = <Book>[].obs;


  Future<String> getUserId() async{
    var user = await _bookController.getUserId();
    return user;
  }

  Future<void> getLibrary() async {
    var userId = await getUserId();
    List<Book> library = await _bookController.getExistingLibrary(userId);
    books.value = library;
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
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              child: Text(
                book.author.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff543c43),
                  fontSize: 14,
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
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "read: ${book.read}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff543c43),
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ),
            Container(
              child: Text(
                book.opinion?.isNotEmpty == true ?
                  "${book.opinion}" :  "no opinion..",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff543c43),
                  fontSize: 16,
                ),
              ),
            )
          ],
        ));
  }

  Future<void> toEditLibrary() async{
    Get.toNamed('/editLibrary');
  }


  @override
  Widget build(BuildContext context) {
    getLibrary();
    return Scaffold(
      appBar: AppBar(
        title: const Text('library'),
        actions: [
          IconButton(
              onPressed: () {
                toEditLibrary();
              },
              icon: const Icon(Icons.edit))
        ],
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
              child: Obx(() => ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return createBooksCard(books[index]);
                },
              ),)
            ),
          ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
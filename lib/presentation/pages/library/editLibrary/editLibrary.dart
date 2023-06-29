import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';

import '../../../../domain/entities/book.dart';
import '../../../controllers/book_controller.dart';
import '../../../controllers/auth_controller.dart';
import '../../navigation_bar/custom_navigation_bar.dart';
import 'editCurrentBook/editCurrentBookPage.dart';

class EditLibraryPage extends StatelessWidget{
  EditLibraryPage({Key? key}) : super(key: key);
  final _bookController = Get.find<BookController>();
  RxInt booksLength = 0.obs;
  RxList<Book> books = <Book>[].obs;

  Future<String> getUserId() async{
    var user = await _bookController.getUserId();
    return user;
  }

  Future<void> getLibrary() async {
    var userId = await getUserId();
    books.value = await _bookController.getExistingLibrary(userId);
  }

  void goToEditCurrentBookPage(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCurrentBookPage(currentBook: book),
      ),
    );
  }

  Widget createBooksCard(BuildContext context, Book book) {
    return Row(
          children:[
            Expanded(
                flex:6,
                child: Card(
                  child:
                  Column(
                    children: [
                      Container(
                        //margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          book.title.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3b2a2f),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        //margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          book.author.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff543c43),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "pages: ${book.pages}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff543c43),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "read: ${book.read}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff543c43),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
            ),
          const SizedBox(
            width: 18,
          ),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: (){
                  goToEditCurrentBookPage(context, book);
                },
                child: const Icon(Icons.edit_outlined),
              ),
          )
          ]
        );
  }

  Future<void> addNewBook() async{
    Get.offAllNamed('/addNewBook');
    }

  @override
  Widget build(BuildContext context) {
    getLibrary();
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit library page'),
        actions: [
          IconButton(
              onPressed: () {
                addNewBook();
              },
              icon: const Icon(Icons.add_box_outlined))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return createBooksCard(context, books[index]);
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

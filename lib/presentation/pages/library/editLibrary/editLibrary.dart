import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';

import '../../../../domain/entities/book.dart';
import '../../../controllers/book_controller.dart';
import '../../auth/auth_controller.dart';
import '../../navigation_bar/custom_navigation_bar.dart';
import 'editCurrentBook/editCurrentBookPage.dart';

class EditLibraryPage extends StatelessWidget{
  EditLibraryPage({Key? key}) : super(key: key);
  final _authController = Get.find<AuthController>();
  final _bookController = Get.find<BookController>();
  RxInt booksLength = 0.obs;
  RxList<Book> books = <Book>[].obs;

  //final User? user = FirebaseAuthSource().currentUser;
  Future<void> signOut() async {
    await _authController.signOutUserUsecase.execute();
  }
  Future<String> userId() async{
    var user = await _authController.getLoggedUser.execute();
    return user.email;
    //return Text(user?.email ?? 'user email');
  }

  Future<void> getLibrary() async {
    var userId = await _bookController.getLoggedUsername();
    List<Book> library = await _bookController.getExistingLibrary(userId.email);
    books.value = library;
  }

  void goToEditCurrentBookPage(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCurrentBookPage(currentBook: book),
      ),
    );
  }

  // Future<void> toEditCurrentBook() async{
  //   Get.toNamed('/editCurrentBook');
  // }

  Widget createBooksCard(BuildContext context, Book book) {
    return Card(
        child: Row(
          children: [
            Column(
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
                    margin: const EdgeInsets.only(left:14),
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
            ),
            ElevatedButton(
                onPressed: (){
                  goToEditCurrentBookPage(context, book);
                },
                child: const Icon(Icons.edit_outlined))
          ],
        )
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
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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

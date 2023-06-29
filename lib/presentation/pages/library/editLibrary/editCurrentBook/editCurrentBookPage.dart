import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';
import 'package:lsm_project/presentation/pages/library/editLibrary/editCurrentBook/removeCurrentBook.dart';
import 'package:lsm_project/presentation/pages/library/editLibrary/editCurrentBook/updateCurrentBookPage.dart';

import '../../../../../app/util/dependency_creator.dart';
import '../../../../../domain/entities/book.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../navigation_bar/custom_navigation_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import '../../libraryPageBindings.dart';

class EditCurrentBookPage extends StatelessWidget{
  final Book currentBook;
  EditCurrentBookPage({Key? key, required this.currentBook}) : super(key: key);
  final _bookController = Get.find<BookController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _readController = TextEditingController();
  final TextEditingController _likeController = TextEditingController();
  final TextEditingController _opinionController = TextEditingController();



  Future<String> getUserId() async{
    var user = await _bookController.getUserId();
    return user;
  }
  void goToUpdateCurrentBookPage(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateCurrentBookPage(currentBook: book),
      ),
    );
  }
  void goToRemoveCurrentBookPage(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemoveCurrentBookPage(currentBook: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('edit current book'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  child: Column(
                      children: [
                          Container(
                            child: Text(
                              currentBook.title.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3b2a2f),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              currentBook.author.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff543c43),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "pages: ${currentBook.pages}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff543c43),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "read: ${currentBook.read}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff543c43),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                          )
                        ],
                )),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    currentBook.opinion?.isNotEmpty == true ? "${currentBook.opinion}" :  "no opinion..",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff543c43),
                      fontSize: 18,
                    ),
                  ),
                )
              ),
              const SizedBox(
                height: 195,
              ),
              ElevatedButton(
                onPressed: () {
                  goToUpdateCurrentBookPage(context, currentBook);
                },
                child: const Text('update current book', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  goToRemoveCurrentBookPage(context, currentBook);
                },
                child: const Text('remove current book', style: TextStyle(fontSize: 16)),
              ),

            ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
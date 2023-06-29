import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';

import '../../../../domain/entities/book.dart';
import '../../../controllers/auth_controller.dart';
import '../../navigation_bar/custom_navigation_bar.dart';
import 'package:uuid/uuid.dart';

class AddNewBookPage extends StatelessWidget{
  AddNewBookPage({Key? key}) : super(key: key);
  final _bookController = Get.find<BookController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _readController = TextEditingController();
  final TextEditingController _likeController = TextEditingController();
  final TextEditingController _opinionController = TextEditingController();



  RxInt booksLength = 0.obs;
  RxList<Book> books = <Book>[].obs;

  Future<String> getUserId() async{
    var user = await _bookController.getUserId();
    return user;
  }


  Widget createTextField(TextEditingController controller, String title) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Future<void> toEditLibrary() async{
    Get.toNamed('/editLibrary');
  }

  Book createBook(String title, String author, String pages,
      String read, String like, String opinion) {
    String _title = title.toString();
    String _author = author.toString();
    int _pages = int.parse(pages);
    bool _read,_like;
    if(read == "yes"){
      _read = true;
    } else {
      _read = false;
    }
    if(like == "yes"){
      _like = true;
    } else {
      _like = false;
    }
    String _opinion = opinion.toString();
    return Book(
      id: Uuid().v1.toString(),
      title: _title,
      author: _author,
      pages: _pages,
      read: _read,
      like: _like,
      opinion: _opinion
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('add new book'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createTextField(_titleController, "the title"),
              createTextField(_authorController, "the author"),
              createTextField(_pagesController, "how much pages"),
              createTextField(_readController, "have you read it? yes/no"),
              createTextField(_likeController, "do you like it? yes/no"),
              createTextField(_opinionController, "your little opinion about this book"),
              ElevatedButton(
                onPressed: () async {
                  Book book = createBook(
                      _titleController.text, _authorController.text, _pagesController.text,
                    _readController.text, _likeController.text, _opinionController.text
                  );
                  bool answer = await _bookController.addBookToLibrary(book, await getUserId());
                  print("ADDED???");
                  print(answer);
                  Get.toNamed('/editLibrary');
                },
                child: Text('add Book'),
              ),

            ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
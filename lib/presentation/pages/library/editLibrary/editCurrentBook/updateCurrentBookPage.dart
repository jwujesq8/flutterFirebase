import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';

import '../../../../../domain/entities/book.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../navigation_bar/custom_navigation_bar.dart';
import 'package:uuid/uuid.dart';

class UpdateCurrentBookPage extends StatelessWidget{
  final Book currentBook;
  UpdateCurrentBookPage({Key? key, required this.currentBook}) : super(key: key);
  final _authController = Get.find<AuthController>();
  final _bookController = Get.find<BookController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _readController = TextEditingController();
  final TextEditingController _likeController = TextEditingController();
  final TextEditingController _opinionController = TextEditingController();


  Future<String> userId() async{
    var user = await _authController.getLoggedUser.execute();
    return user.email;
  }

  Widget createTextField(TextEditingController controller, String title, String hintText) {
    return Padding(
        padding: const EdgeInsets.only(top: 5,bottom: 10),
        child: TextField(
          controller: controller..text = hintText,
          decoration: InputDecoration(
            labelText: title,
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: Color(0xff3b2a2f),
                  width: 4
              ),
            ),
            contentPadding: const EdgeInsets.all(5),
          ),
        ));
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
        title: const Text('update current book'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              createTextField(_titleController, "title", currentBook.title),
              createTextField(_authorController, "author", currentBook.author),
              createTextField(_pagesController, "count of pages", currentBook.pages.toString()),
              createTextField(_readController, "have you read it? yes/no",  currentBook.read==true ? "yes" : "no"),
              createTextField(_likeController, "do you like it? yes/no", currentBook.like==true ? "yes" : "no"),
              createTextField(_opinionController, "opinion", currentBook.opinion?.isEmpty==true ? "no opinion.." : "${currentBook.opinion}"),
              ElevatedButton(
                  onPressed: () async {
                    Book newBook = createBook(_titleController.text,
                        _authorController.text, _pagesController.text,
                        _readController.text, _likeController.text, _opinionController.text);
                    await _bookController.updateBook(currentBook, newBook, await userId());

                    Get.toNamed('library');
                  },
                  child: const Text("confirm changes", style: TextStyle( fontSize: 18),))
            ]
        ),
      )

      );
  }

}
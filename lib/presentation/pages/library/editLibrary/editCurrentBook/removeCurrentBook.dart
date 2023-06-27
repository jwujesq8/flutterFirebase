import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';

import '../../../../../domain/entities/book.dart';
import '../../../auth/auth_controller.dart';
import '../../../navigation_bar/custom_navigation_bar.dart';
import 'package:uuid/uuid.dart';

class RemoveCurrentBookPage extends StatelessWidget{
  final Book currentBook;
  RemoveCurrentBookPage({Key? key, required this.currentBook}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('remove current book'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text ("Remove book"),
              Card(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          currentBook.title.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3b2a2f),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          currentBook.author.toString(),
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
                                "pages: ${currentBook.pages}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff543c43),
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "read: ${currentBook.read}",
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
                  )),

            ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
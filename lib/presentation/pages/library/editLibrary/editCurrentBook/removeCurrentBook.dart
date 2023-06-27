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
        padding: const EdgeInsets.only(left: 55, right: 55),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text (
                "Are you sure that you want to remove that book?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3b2a2f),
                  fontSize: 22,
                ),
              ),
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
              Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      currentBook.opinion?.isNotEmpty == true ? "${currentBook.opinion}" :  "no opinion..",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff543c43),
                        fontSize: 15,
                      ),
                    ),
                  )
              ),
              SizedBox(height: 155),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Get.offAllNamed('/library');
                      },
                      child: const Text("no")),
                  ElevatedButton(
                      onPressed: () async {
                        bool answer = await _bookController.removeBookFromLibrary(currentBook, await userId());

                        Get.offAllNamed('/library');
                      },
                      child: const Text("yes")),
                ],
              )

            ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
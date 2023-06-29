import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/book_controller.dart';

import '../../../../../domain/entities/book.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../navigation_bar/custom_navigation_bar.dart';
import 'package:uuid/uuid.dart';

class RemoveCurrentBookPage extends StatelessWidget{
  final Book currentBook;
  RemoveCurrentBookPage({Key? key, required this.currentBook}) : super(key: key);
  final _bookController = Get.find<BookController>();

  Future<String> getUserId() async{
    var user = await _bookController.getUserId();
    return user;
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
                  fontSize: 27,
                ),
              ),
              const SizedBox(height: 30),
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
                          margin: EdgeInsets.only(left:14),
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
              SizedBox(height: 155),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Get.offAllNamed('/library');
                      },
                      child: const Text("no", style: TextStyle(fontSize: 18))),
                  ElevatedButton(
                      onPressed: () async {
                        bool answer = await _bookController.removeBookFromLibrary(currentBook, await getUserId());

                        Get.offAllNamed('/library');
                      },
                      child: const Text("yes", style: TextStyle(fontSize: 18))),
                ],
              )

            ]

        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),


    );
  }

}
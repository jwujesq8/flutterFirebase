import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/controllers/home_pages_controller.dart';
import 'package:lsm_project/presentation/controllers/quote_controller.dart';
import 'package:lsm_project/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/navigation_bar/custom_navigation_bar.dart';

import '../../../domain/entities/auth_user.dart';
import '../../../domain/entities/quote.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);
  final _quoteController = Get.find<QuoteController>();
  Rx<Quote> quote = Quote(id: '', text: '', book: "").obs;


  Future<void> randomQuote() async {
    Random random = Random();

    var userId = await _quoteController.getUserId();
    List<Quote> quotesList = await _quoteController.getExistingQuotes(userId);

    print("QUOTES FROM HOME:");
    print(quotesList);

    int randomInt = random.nextInt(quotesList.length);
    quote.value = quotesList[randomInt];
    print(quote.value.text);

  }
  Widget createQuoteCard() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 12.0,top: 15.0, right: 15.0, bottom: 10.0),
                  child: Column(
                    children: [
                      Text(
                        '${' ' * 5}${quote.value.text}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3b2a2f),
                            fontSize: 18,
                            fontFamily: 'Ysabeau-Italic'
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(
                                quote.value.book,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3b2a2f),
                                    fontSize: 14,
                                    fontFamily: 'Ysabeau-Italic'
                                ),
                              ),
                            )
                          ]
                      )
                    ],
                  ))


            ],
          ),
        ),
        );
  }

  @override
  Widget build(BuildContext context) {
    randomQuote();

    return Scaffold(
      appBar: AppBar(
        title: const Text('library app'),
      ),
       body: Column(
         children: [
           const Padding(
             padding: EdgeInsets.only(left: 15, right: 15),
             child: Card(
               elevation: 40,
               shadowColor: Color(0xff3b2a2f),
               color: Color(0xaa3b2a2f),
               child: SizedBox(
                 width: double.infinity,
                 child: Center(
                   child: Text("quote for the present moment",
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.white,
                       fontSize: 25,
                     ),
                   ),
                 )
               )
             )
           ),
           Obx(() => createQuoteCard()),
           Row(
             children: [
               Expanded(
                   flex: 1,
                   child: Padding(
                     padding: EdgeInsets.only(left: 15),
                     child: Card(
                       child: Column(
                         children: const [
                           Text("pages read"),
                           //showPagesRead(),
                         ],
                       ),
                     ),
                   )
               ),
               Expanded(
                   flex: 1,
                   child: Padding(
                     padding: EdgeInsets.only(right: 15),
                     child: Card(
                       child: Column(
                         children: const [
                           Text("books read"),
                           //showBooksRead(),
                         ],
                       ),
                     ),
                   )
               )
             ],
           )
         ],
       ),
      bottomNavigationBar: const CustomNavigationBar(),

    );
  }

}

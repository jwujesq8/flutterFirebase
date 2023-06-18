import 'dart:convert';
import 'package:lsm_project/data/models/book_model.dart';
import 'package:firebase_database/firebase_database.dart';

class BookDataSource {
  Future<BookModel> getLibrary(String userId) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(userId).get();
    if (snapshot.exists) {
      return BookModel.fromJson(json.decode(snapshot.value as String));
    } else {
      print('No data available.');
      return BookModel(id: '', title: '', author: '');
    }


  }
}
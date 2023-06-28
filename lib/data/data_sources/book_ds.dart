import 'dart:convert';
import 'package:lsm_project/data/models/book_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/book.dart';

class BookDataSource {

  CollectionReference<Map<String, dynamic>> getFirestoreCollection(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  Future<List<Book>> getLibrary(String userId) async {
    final ref = FirebaseFirestore.instance.collection('library_$userId');

    final snapshot = await ref.get();
    if (snapshot.size > 0) {
      print("snapshot.size > 0");
      return snapshot.docs.map((doc) {
        final data = doc.data();
        print(data);
        return Book(
          id: doc.id,
            title: data["title"],
            author: data["author"],
            pages: data["pages"] ?? '',
            read: data["read"],
            like: data["like"],
            opinion: data["opinion"] ?? ''
        );
      }).toList();
      //return BookModel.fromJson(json.decode(snapshot.docs as String));
    } else {
      print('No data available.');
      return [];
    }
  }
  Future<void> closeBooksConnection() async{
    FirebaseFirestore.instance.terminate();
  }
}
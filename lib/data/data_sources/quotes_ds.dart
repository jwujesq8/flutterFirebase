import 'dart:convert';
import 'package:lsm_project/data/models/book_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/quote.dart';

class QuoteDataSource {

  CollectionReference<Map<String, dynamic>> getFirestoreCollection(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  Future<List<Quote>> getQuotes(String userId) async {
    print("USERiD in quotes ds:");
    print(userId);
    final ref = FirebaseFirestore.instance.collection("quotes_$userId");

    final snapshot = await ref.get();
    if (snapshot.size > 0) {
      print("quotes.size > 0");
      return snapshot.docs.map((doc) {
        final data = doc.data();
        print(data);
        return Quote(
            id: doc.id,
            text: data["text"],
            book: data["book"]
        );
      }).toList();
    } else {
      print('No quotes available.');
      return [];
    }
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsm_project/domain/entities/book.dart';

class BookModel{
  String id;
  String title;
  String author;
  int? pages;
  bool? read;
  bool? like;
  String? opinion;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.pages,
    this.read,
    this.like,
    this.opinion
  });

  factory BookModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data()!;
    return BookModel(
      id: json.id,
      title: data["title"],
      author: data["author"],
      pages: data["pages"] ?? '',
      read: data["read"],
      like: data["like"],
      opinion: data["opinion"] ?? ''
    );
  }

  Future<Book> toEntity() {
    return Future.value(Book(
      id: id,
      title: title,
      author: author,
      pages: pages,
      read: read,
      like: like,
      opinion: opinion
    ));
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'pages': pages ?? '',
      'read': read,
      'like': like,
      'opinion': opinion ?? ''
    };
  }
}
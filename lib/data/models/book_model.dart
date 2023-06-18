import 'dart:html';

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

  factory BookModel.fromJson(Map<Object, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      pages: json['pages'] ? json['pages'] : '',
      read: json['read'] ? json['read'] : null,
      like: json['like'] ? json['like'] : null,
      opinion: json['opinion'] ? json['opinion'] : ''
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
}
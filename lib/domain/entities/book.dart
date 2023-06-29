class Book {
  String id;
  String title;
  String author;
  int? pages;
  bool? read;
  bool? like;
  String? opinion;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.pages,
    this.read,
    this.like,
    this.opinion
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'pages': pages,
      'read': read,
      'like': like,
      'opinion': opinion,
    };
  }

}

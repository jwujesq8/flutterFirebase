class Book {
  String id;
  String title;
  String author;
  int? pages;
  bool read;
  bool? like;
  String? opinion;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.pages,
    required this.read,
    this.like,
    this.opinion
  });
}

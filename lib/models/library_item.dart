import 'user.dart';

abstract class LibraryItem {
  final String title;
  final String? author;
  final DateTime? publishDate;

  User? borrower;
  DateTime? dueDate;

  LibraryItem({
    required this.title,
    this.author,
    this.publishDate,
    this.borrower,
    this.dueDate,
  });
}

class Book extends LibraryItem {
  final int? pageCount;
  final String? isbn;

  Book({
    required super.title,
    super.author,
    super.publishDate,
    super.borrower,
    this.pageCount,
    this.isbn
  });

}

class Magazine extends LibraryItem {
  final int? issueNumber;
  final String? publisher;

  Magazine({
    required super.title,
    super.author,
    super.publishDate,
    this.issueNumber,
    this.publisher,
  });
}
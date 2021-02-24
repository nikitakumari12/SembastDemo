import 'package:flutter/rendering.dart';

class Library {
  int id;
  String bookname;
  String authorname;
  String bookCopies;

  Library({
    this.id,
    this.bookname,
    this.authorname,
    this.bookCopies,
  });

  factory Library.fromJson(Map<String, dynamic> json) => Library(
        id: json["id"],
        bookname: json["bookname"],
        authorname: json["authorname"],
        bookCopies: json["bookCopies"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookname": bookname,
        "authorname": authorname,
        "bookCopies": bookCopies,
      };

  @override
  String toString() {
    // TODO: implement toString
    return """
    id: $id,
    bookname: $bookname,
    authorname: $authorname
    bookCopies: $bookCopies
    """;
  }
}

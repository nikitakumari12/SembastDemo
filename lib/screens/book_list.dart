import 'package:flutter/material.dart';
import 'package:book_managment/screens/book_tile.dart';
import 'package:book_managment/utils/BookDAO.dart';
import 'package:provider/provider.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return BookTile(tileIndex: index);
      },
      itemCount: Provider.of<BookDAO>(context).booksCount,
    );
  }
}

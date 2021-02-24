import 'package:flutter/material.dart';
import 'package:book_managment/Model/LibraryModel.dart';
import 'package:book_managment/book_edit.dart';
import 'package:book_managment/utils/BookDAO.dart';
import 'package:provider/provider.dart';

class BookTile extends StatelessWidget {
  final int tileIndex;

  // Constructor
  BookTile({this.tileIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDAO>(
      builder: (context, bookData, child) {
        Library currentbook = bookData.bookList[tileIndex];

        return ListTile(
          onTap: () {
            Provider.of<BookDAO>(context, listen: false)
                .setActiveBook(currentbook.id);

            // Navigate to view
            Navigator.pushNamed(context, BookEditScreen.screenId);
          },
          title: Text(
            currentbook.bookname ?? "Add Book",
          ),
          subtitle: Text(
            currentbook.authorname ?? "",
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () async {
                  await Provider.of<BookDAO>(context, listen: false)
                      .deleteContact(currentbook.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:book_managment/Model/LibraryModel.dart';
import 'package:book_managment/screens/add_book.dart';
import 'package:book_managment/screens/book_list.dart';
import 'package:book_managment/utils/BookDAO.dart';
import 'package:provider/provider.dart';

class BookViewScreen extends StatelessWidget {
  static const String screenId = '/book_list';

  /// Returns a helpful message if there are not yet any contacts
  Widget helpTip() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "No Books Found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get book list from db on initial build
    Provider.of<BookDAO>(context, listen: false).getAllBooksByName();

    return Consumer<BookDAO>(builder: (context, bookData, child) {
      int numOfbooks = bookData.booksCount;

      return Scaffold(
        appBar: AppBar(
          title: Text('Books'),
        ),
        body: (numOfbooks == 0) ? helpTip() : BookList(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add New Book',
          child: Icon(Icons.person_add),
          onPressed: () async {
            // Navigate to the activeContact editor
            int newbookId = await Provider.of<BookDAO>(context, listen: false)
                .createNewBook();
            print("New book created with id of: " + newbookId.toString());

            // Set the new contact as the "activeContact"
            await Provider.of<BookDAO>(context, listen: false)
                .setActiveBook(newbookId);
            Navigator.pushNamed(context, AddBookScreen.screenId);
          },
        ),
      );
    });
  }
}

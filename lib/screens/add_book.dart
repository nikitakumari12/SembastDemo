import 'package:flutter/material.dart';
import 'package:book_managment/Model/LibraryModel.dart';
import 'package:book_managment/utils/BookDAO.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatefulWidget {
  static const String screenId = '/add_book_screen';

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variables to hold validation errors
  String authorerror;
  String nameError;
  String copiesError;

  // Set Up Field Controllers
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _copiesController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _authorController.dispose();
    _nameController.dispose();
    _copiesController.dispose();
    super.dispose();
  }

  Widget editForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Add Book",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'BookName',
                    hintText: 'BookName',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required.';
                    }
                    if (nameError != null) {
                      return nameError;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _authorController,
                  decoration: InputDecoration(
                    labelText: 'Author Name',
                    hintText: 'Author Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required.';
                    }
                    if (authorerror != null) {
                      return authorerror;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _copiesController,
                  decoration: InputDecoration(
                    labelText: 'No of Copies',
                    hintText: 'No of Copies',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required.';
                    }
                    if (copiesError != null) {
                      return copiesError;
                    }
                    return null;
                  },
                ),
                RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    // Reset optional validators
                    setState(() {
                      nameError = null;
                    });
                    setState(() {
                      authorerror = null;
                    });
                    setState(() {
                      copiesError = null;
                    });

                    if (_formKey.currentState.validate()) {
                      try {
                        // SAVE
                        Library activeBook =
                            Provider.of<BookDAO>(context, listen: false)
                                .getActiveContact;

                        activeBook.bookname = _nameController.text;
                        activeBook.authorname = _authorController.text;
                        activeBook.bookCopies = _copiesController.text;

                        await Provider.of<BookDAO>(context, listen: false)
                            .updatBook();

                        // POP to return to the contacts list
                        Navigator.pop(context);
                      } catch (e) {
                        print(e.code);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddBook"),
        actions: <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: editForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

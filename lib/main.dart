import 'package:flutter/material.dart';
import 'package:book_managment/BookView.dart';
import 'package:book_managment/book_edit.dart';
import 'package:book_managment/screens/add_book.dart';
import 'package:book_managment/utils/BookDAO.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast_io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookDAO(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: BookViewScreen.screenId,
          routes: {
            BookViewScreen.screenId: (context) => BookViewScreen(),
            BookEditScreen.screenId: (context) => BookEditScreen(),
            AddBookScreen.screenId: (context) => AddBookScreen(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return BookViewScreen();
  }
}

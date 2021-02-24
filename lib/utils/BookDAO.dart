import 'package:sembast/sembast.dart';
import 'package:book_managment/Model/LibraryModel.dart';
import 'DatabaseDemo.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart' as random_string;

class BookDAO extends ChangeNotifier {
  static const String folderName = "Library";
  final _libFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;
  List<Library> _books = [];
  Library _activeBooks;

  Future<int> createNewBook() async {
    // Generate a random ID based on the date and a random string for virtual zero chance of duplicates
    int _id = DateTime.now().millisecondsSinceEpoch +
        int.parse(random_string.randomNumeric(2));

    Library newContact = Library(id: _id);

    await _libFolder.record(_id).put(await _db, newContact.toJson());

    _books = await getAllBooksByName();

    // Return the ID
    return _id;
  }

  Future<List<Library>> getAllBooksByName() async {
    // Finder allows for filtering / sorting
    final finder = Finder(sortOrders: [SortOrder('bookname')]);

    // Get the data using our finder for sorting
    final bookSnapshots = await _libFolder.find(
      await _db,
      finder: finder,
    );

    List<Library> books = bookSnapshots.map((snapshot) {
      final bookdata = Library.fromJson(snapshot.value);
      return bookdata;
    }).toList();

    // Update UI
    _books = books;
    notifyListeners();

    return books;
  }

  Future<void> updatBook() async {
//    print("Saving Active book, id: " + _activeBook.id.toString());
    final finder = Finder(filter: Filter.byKey(_activeBooks.id));

    // Perform the update converting, converting the book to json, and updating the value at key identified by the finder
    await _libFolder.update(await _db, _activeBooks.toJson(), finder: finder);
    await getAllBooksByName();

    return;
  }

  Future<void> deleteContact(int id) async {
    await _libFolder.record(id).delete(await _db);
    await getAllBooksByName();

    return;
  }

  Future<List<Library>> getAllBooks() async {
    final recordSnapshot = await _libFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final booksData = Library.fromJson(snapshot.value);
      return booksData;
    }).toList();
  }

  int get booksCount {
    return _books.length;
  }

  List<Library> get bookList {
    return _books;
  }

  Future<void> setActiveBook(int id) async {
    _activeBooks = await getBookDetail(id);
    notifyListeners();
    return;
  }

  Future<Library> getBookDetail(int id) async {
    // Get the book JSON from the sembast DB
    var record = await _libFolder.record(id).get(await _db);
    Library bookdata = Library.fromJson(record);

    return bookdata;
  }

  Library get getActiveContact {
    return _activeBooks;
  }
}

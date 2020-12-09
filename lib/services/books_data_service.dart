import 'package:rxdart/rxdart.dart';
import 'package:nested_navigator_2/models/book.dart';

class BooksDataService {
  /// books
  BehaviorSubject<List<Book>> _booksListBS;
  ValueStream<List<Book>> booksListSub;

  /// current book
  BehaviorSubject<Book> _currentBookBS;
  ValueStream<Book> currentBookSub;

  BooksDataService() {
    /// seed a collection of books
    _booksListBS = BehaviorSubject.seeded([
      Book(1, 'Stranger in a Strange Land', 'Robert A. Heinlein'),
      Book(2, 'Foundation', 'Isaac Asimov'),
      Book(3, 'Fahrenheit 451', 'Ray Bradbury'),
    ]);

    booksListSub = _booksListBS.stream;

    _currentBookBS = BehaviorSubject<Book>();
    currentBookSub = _currentBookBS.stream;
  }

  void dispose() {
    _currentBookBS.close();
    _booksListBS.close();
  }

  void unsetCurrentBook() {
    if (_currentBookBS.hasValue && _currentBookBS.value is Book) {
      _currentBookBS.add(null);
    }
  }

  void setCurrentBookById(int id) {
    /// attempt to find by id
    var book = booksListSub.value
        .firstWhere((element) => element.id == id, orElse: () => null);

    _currentBookBS.add(book);
  }
}

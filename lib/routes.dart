abstract class BookRoutePath {}

class BooksListPath extends BookRoutePath {}

class BooksSettingsPath extends BookRoutePath {}

class BookDetailsPath extends BookRoutePath {
  final int id;

  BookDetailsPath(this.id);
}

class BookUnknownPath extends BookRoutePath {}

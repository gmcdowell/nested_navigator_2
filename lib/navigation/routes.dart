const String URL_HOME = '/';
const String URL_BOOK = 'book';
const String URL_SETTINGS = 'settings';
const String URL_UNKNOWN = '404';

abstract class RoutePath {}

class BooksListPath extends RoutePath {
  static const String path = URL_HOME;

  static String get url => URL_HOME;
}

class SettingsPath extends RoutePath {
  static const String path = URL_SETTINGS;

  static String get url => '$URL_HOME$URL_SETTINGS';
}

class BookDetailsPath extends RoutePath {
  static const String path = URL_BOOK;

  static String get url => '$URL_HOME$URL_BOOK/:id';

  final int id;

  BookDetailsPath(this.id);
}

class UnknownPath extends RoutePath {
  static const String path = URL_UNKNOWN;

  static String get url => '$URL_HOME$URL_UNKNOWN';
}

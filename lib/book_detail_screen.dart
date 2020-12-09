import 'package:flutter/material.dart';
import 'package:nested_navigator_2/book.dart';


class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({
    Key key,
    @required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book is Book) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ]
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nested_navigator_2/core/abstract_widget_view.dart';
import 'package:nested_navigator_2/models/book.dart';
import 'package:nested_navigator_2/services/books_data_service.dart';

class BooksListScreen extends StatefulWidget {
  @override
  _BooksListScreenController createState() => _BooksListScreenController();
}

class _BooksListScreenController extends State<BooksListScreen> {
  BooksDataService _booksDataService;

  @override
  void initState() {
    super.initState();

    _booksDataService = Provider.of<BooksDataService>(context, listen: false);
  }

  void handleOnTap(int idx) {
    print('idx: $idx');
    _booksDataService.setCurrentBookById(idx);
  }

  @override
  Widget build(BuildContext context) => _BooksListScreenView(this);
}

class _BooksListScreenView
    extends WidgetView<BooksListScreen, _BooksListScreenController> {
  _BooksListScreenView(_BooksListScreenController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
        stream: state._booksDataService.booksListSub,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Books'),
              ),
              body: ListView(
                children: [
                  for (var book in snapshot.data)
                    ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () => state.handleOnTap(book.id),
                    )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

// class BooksListScreen extends StatelessWidget {
//   final ValueChanged<Book> onTapped;
//
//   BooksDataService _booksDataService;
//
//   BooksListScreen({
//     @required this.onTapped,
//   }) {
//     // _booksDataService = Provider.of<BooksDataService>(context, listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Book>>(
//         stream:
//             Provider.of<BooksDataService>(context, listen: false).booksListSub,
//         builder: (context, snapshot) {
//           if (snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.active) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text('Books'),
//               ),
//               body: ListView(
//                 children: [
//                   for (var book in snapshot.data)
//                     ListTile(
//                       title: Text(book.title),
//                       subtitle: Text(book.author),
//                       onTap: () => onTapped(book),
//                     )
//                 ],
//               ),
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         });
//   }
// }
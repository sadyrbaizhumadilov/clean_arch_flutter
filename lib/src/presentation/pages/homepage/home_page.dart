import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_books_repositories.dart';
import '../add_books/add_books_view.dart';
import 'home_controller.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(DataBookRepository()));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
        floatingActionButton: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
            return FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBooksView(),
                    ));
              },
            );
          },
        ),
        key: globalKey,
        body: Column(children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: padding.top + 20),
                ControlledWidgetBuilder<HomeController>(
                  builder: (context, controller) {
                    if (controller.books != null &&
                        controller.books!.isNotEmpty) {
                      return Column(
                        children: [
                          for (int i = 0; i < controller.books!.length; i++)
                            _BooksCard(
                              controller.books![i],
                              controller.removeBooks,
                            ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ]));
  }
}

class _BooksCard extends StatelessWidget {
  final Books books;
  final Function(String bookId) removeBooks;

  _BooksCard(this.books, this.removeBooks);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17),
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            books.imageUrl,
            width: 100,
            height: 100,
          ),
          Column(
            children: [
              Text(
                books.kitap,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                books.year,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              removeBooks(books.id);
            },
            child: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
    );
  }
}

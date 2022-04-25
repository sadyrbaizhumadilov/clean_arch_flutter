import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';
import 'package:clean_arch_flutter/src/domain/usecases/remove_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'home_presenter.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(BooksRepositories _booksRepository)
      : _presenter = HomePresenter(_booksRepository);

  List<Books>? books;

  @override
  void onInitState() {
    _presenter.getBooks();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getBooksOnNext = (List<Books>? response) {
      books = response;
      refreshUI();
    };

    _presenter.getBooksOnError = (e) {};

    _presenter.removeBooksOnComplete = () {};

    _presenter.removeBooksOnError = (e) {};
  }

  void removeBooks(String bookId) {
    _presenter.removeBooks(bookId);
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}

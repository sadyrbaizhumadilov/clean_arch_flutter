import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecases/get_books.dart';

class HomePresenter extends Presenter {
  late Function getBooksOnNext;
  late Function getBooksOnError;

  final GetBooks _getBooks;

  HomePresenter(BooksRepositories _booksRepository)
      : _getBooks = GetBooks(_booksRepository);

  void getBooks() {
    _getBooks.execute(_GetBooksObserver(this));
  }

  @override
  void dispose() {
    _getBooks.dispose();
  }
}

class _GetBooksObserver extends Observer<List<Books>> {
  final HomePresenter _presenter;

  _GetBooksObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getBooksOnError(e);
  }

  @override
  void onNext(List<Books>? response) {
    _presenter.getBooksOnNext(response);
  }
}

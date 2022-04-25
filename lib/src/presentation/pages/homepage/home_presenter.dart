import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';
import 'package:clean_arch_flutter/src/domain/usecases/remove_books.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecases/add_books.dart';
import '../../../domain/usecases/get_books.dart';

class HomePresenter extends Presenter {
  late Function getBooksOnNext;
  late Function getBooksOnError;

  late Function removeBooksOnComplete;
  late Function removeBooksOnError;

  final GetBooks _getBooks;
  final RemoveBooks _removeBooks;

  HomePresenter(BooksRepositories _booksRepository)
      : _getBooks = GetBooks(_booksRepository),
        _removeBooks = RemoveBooks(_booksRepository);

  void getBooks() {
    _getBooks.execute(_GetBooksObserver(this));
  }

  void removeBooks(String booksId) {
    _removeBooks.execute(
        _RemoveBooksObserver(this), RemoveBooksParams(booksId));
  }

  @override
  void dispose() {
    _getBooks.dispose();
    _removeBooks.dispose();
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

class _RemoveBooksObserver extends Observer<void> {
  final HomePresenter _presenter;
  _RemoveBooksObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.removeBooksOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeBooksOnError(e);
  }

  @override
  void onNext(_) {}
}

import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecases/add_books.dart';

class AddBooksPresenter extends Presenter {
  late Function addBooksOnComplete;
  late Function addBooksOnError;

  final AddBooks _addBooks;

  AddBooksPresenter(BooksRepositories _booksRepository)
      : _addBooks = AddBooks(_booksRepository);

  @override
  void dispose() {
    _addBooks.dispose();
  }

  void addBooks(Books books) {
    _addBooks.execute(_AddBooksObserver(this), AddBooksParams(books));
  }
}

class _AddBooksObserver extends Observer<void> {
  final AddBooksPresenter _presenter;

  _AddBooksObserver(this._presenter);
  @override
  void onComplete() {
    _presenter.addBooksOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addBooksOnError(e);
  }

  @override
  void onNext(_) {}
}

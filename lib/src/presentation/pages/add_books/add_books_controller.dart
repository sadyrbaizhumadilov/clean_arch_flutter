import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/repositories/books_repository.dart';
import 'add_books_presenter.dart';

class AddBooksController extends Controller {
  final AddBooksPresenter _presenter;

  AddBooksController(BooksRepositories _booksRepository)
      : _presenter = AddBooksPresenter(_booksRepository);

  String title = "";
  String description = "";
  String imageUrl = "";

  @override
  void initListeners() {
    _presenter.addBooksOnComplete = () {
      Navigator.pop(getContext());
      refreshUI();
    };

    _presenter.addBooksOnError = (e) {};
  }

  void onTitleTextFieldChanged(String value) {
    title = value;
    refreshUI();
  }

  void onDescriptionTextFieldChanged(String value) {
    description = value;
    refreshUI();
  }

  void onImageUrlTextFieldChanged(String value) {
    imageUrl = value;
    refreshUI();
  }

  void onAddButtonPressed() {
    final Books books = Books(
      DateTime.now().millisecondsSinceEpoch.toString(),
      title,
      description,
      imageUrl,
    );
    _presenter.addBooks(books);
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}

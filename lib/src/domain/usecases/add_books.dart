import 'dart:async';

import 'package:clean_arch_flutter/src/domain/entities/books.dart';
import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddBooks extends UseCase<void, AddBooksParams> {
  final BooksRepositories _bookRepository;

  AddBooks(this._bookRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(AddBooksParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _bookRepository.addBook(params!.books);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class AddBooksParams {
  final Books books;

  AddBooksParams(this.books);
}

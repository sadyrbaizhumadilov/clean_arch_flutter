import 'dart:async';

import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RemoveBooks extends UseCase<void, RemoveBooksParams> {
  final BooksRepositories _booksRepository;

  RemoveBooks(this._booksRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(RemoveBooksParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _booksRepository.removeBook(params!.booksId);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class RemoveBooksParams {
  final String booksId;

  RemoveBooksParams(this.booksId);
}

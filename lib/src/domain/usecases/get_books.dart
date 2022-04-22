import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/books.dart';
import '../repositories/books_repository.dart';

class GetBooks extends UseCase<List<Books>, void> {
  final BooksRepositories _booksRepository;
  final StreamController<List<Books>> _controller;

  GetBooks(this._booksRepository) : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Books>?>> buildUseCaseStream(void params) async {
    try {
      _booksRepository.getBooks().listen((List<Books> books) {
        if (!_controller.isClosed) {
          _controller.add(books);
        }
        ;
      });
    } catch (e, st) {
      print(e);
      print(st);
      _controller.addError(e, st);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

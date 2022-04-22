import 'dart:async';

import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';

import '../../domain/entities/books.dart';

class DataBookRepository implements BooksRepositories {
  StreamController<List<Books>> _streamController =
      StreamController.broadcast();

  List<Books> _books = [Books("wdhwld3278e2", "Fareler ve İnsanlar ", "1996")];

  @override
  Stream<List<Books>> getBooks() {
    Future.delayed(Duration.zero).then((_) => _streamController.add(_books));

    return _streamController.stream;
  }
}

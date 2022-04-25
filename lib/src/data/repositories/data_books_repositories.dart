import 'dart:async';

import 'package:clean_arch_flutter/src/domain/repositories/books_repository.dart';

import '../../domain/entities/books.dart';

class DataBookRepository implements BooksRepositories {
  static final _instance = DataBookRepository._internal();
  DataBookRepository._internal();
  factory DataBookRepository() => _instance;
  StreamController<List<Books>> _streamController =
      StreamController.broadcast();

  List<Books> _books = [];
  @override
  Stream<List<Books>> getBooks() {
    _initBooks();

    return _streamController.stream;
  }

  void _initBooks() {
    Future.delayed(Duration.zero).then((_) => _streamController.add(_books));
  }

  @override
  Future<void> addBook(Books books) async {
    try {
      _books.add(books);
      Future.delayed(Duration.zero)
          .then((value) => _streamController.add(_books));
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> removeBook(String booksId) async {
    try {
      _books.remove(_books.firstWhere((books) => books.id == booksId));

      _streamController.add(_books);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}

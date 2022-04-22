import '../entities/books.dart';

abstract class BooksRepositories {
  Stream<List<Books>> getBooks();
}

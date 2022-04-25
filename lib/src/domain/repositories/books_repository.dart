import '../entities/books.dart';

abstract class BooksRepositories {
  Stream<List<Books>> getBooks();
  Future<void> addBook(Books books);
  Future<void> removeBook(String booksId);
}

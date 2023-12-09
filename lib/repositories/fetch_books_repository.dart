import 'package:escribo_ebook/interfaces/client_http_interface.dart';
import 'package:escribo_ebook/models/ebook_model.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository_interface.dart';
import 'package:escribo_ebook/utils/escribo_api.dart';

class FetchBooksRepository implements IFetchBooks {

  // estes são os livros do teu repositório
  List<BookModel> books = [];

  final IClientHttp httpClient;
  FetchBooksRepository({required this.httpClient});

  @override
  Future<List<BookModel>> fetchBooks() async {
    final response = await httpClient.get(EscriboApi.booksApi); // Future<dynamic> -> Future<List<Map>>
    List<BookModel> booklist = [];
    for (final bookRes in response) {
      final book = BookModel.fromMap(bookRes);
      booklist.add(book);
    }
    // List<BookModel> booklist = response.map((Map<String, dynamic> book) => BookModel.fromMap(book)).toList();
    // final bookMap = BookModel.fromMap(response[0]);
    // final bookList = <BookModel>[bookMap];
    books = booklist;
    return booklist;
  }

  // allbooks() -> return books; // contem todos os livros listados na tua sessão
  
  // contem todos os livros listados na tua sessão
  List<BookModel> favoritedBooks() {
    return books.where((book) => book.isFavorited).toList();
  }

  // deviceBooks() -> return onlybooksondevice; // contem todos os livros listados no teu device
}
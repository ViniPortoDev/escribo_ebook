import 'package:escribo_ebook/interfaces/client_http_interface.dart';
import 'package:escribo_ebook/models/ebook_model.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository_interface.dart';
import 'package:escribo_ebook/utils/escribo_api.dart';

class FetchBooksRepository implements IFetchBooks {
  final IClientHttp httpClient;
  FetchBooksRepository({required this.httpClient});
  @override
  Future<List<BookModel>> fetchBooks() async {
    final response = await httpClient.get(EscriboApi.booksApi);
    final bookMap = BookModel.fromMap(response[0]);
    final bookList = <BookModel>[bookMap];
    return bookList;
  }

  // @override
  // Future<List<BookModel>> fetchBooks() async {
  //   final response = await httpClient.get(EscriboApi.booksApi);
  //   final bookMap = BookModel.fromMap(response);
  //   final bookList = <BookModel>[];
  //   return bookList;
  // }
}

import 'package:escribo_ebook/models/ebook_model.dart';

abstract class IFetchBooks {
  Future<List<BookModel>> fetchBooks();
}
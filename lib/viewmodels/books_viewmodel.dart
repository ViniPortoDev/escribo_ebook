import 'package:escribo_ebook/models/ebook_model.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository_interface.dart';
import 'package:flutter/material.dart';

class BooksViewModel {
  final IFetchBooks repository;
  BooksViewModel(this.repository);
  final bookList = ValueNotifier<List<BookModel>>([]);
  fill() async {
   bookList.value = await repository.fetchBooks();
  }
}

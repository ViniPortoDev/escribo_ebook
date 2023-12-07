import 'package:escribo_ebook/viewmodels/books_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../models/ebook_model.dart';

class HomeController {
  final BooksViewModel booksViewModel;
  HomeController(this.booksViewModel);

  ValueNotifier<List<BookModel>> get bookList => booksViewModel.bookList;
  getBooks() {
    booksViewModel.fill();
  }
}

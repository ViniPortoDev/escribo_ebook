import 'package:dio/dio.dart';
import 'package:escribo_ebook/app_widget.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository.dart';
import 'package:escribo_ebook/service/dio_service.dart';
import 'package:flutter/material.dart';

void main() async {
  final dio = Dio();
  final dioService = DioService(dio: dio);
  final fetch = FetchBooksRepository(httpClient: dioService);
  final books = await fetch.fetchBooks();
  print(books[0].title);
  // runApp(AppWidget());
}

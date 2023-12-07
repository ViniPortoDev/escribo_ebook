import 'package:dio/dio.dart';
import 'package:escribo_ebook/models/ebook_model.dart';
import 'package:escribo_ebook/pages/home_page/home_controller.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository.dart';
import 'package:escribo_ebook/service/dio_service.dart';
import 'package:escribo_ebook/viewmodels/books_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:escribo_ebook/utils/escribo_colors.dart';
import 'package:escribo_ebook/pages/home_page/components/book_box_widget.dart';

import 'components/book_toggle_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    controller.getBooks();
  }

  final controller = HomeController(
    BooksViewModel(
      FetchBooksRepository(
        httpClient: DioService(
          dio: Dio(),
        ),
      ),
    ),
  );
  bool positive = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: EscriboColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/Escribo_eBooks.jpg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchBookWidget(
                    positive: positive,
                    onChanged: (b) => setState(() => positive = b),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Todos Livros',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<List<BookModel>>(
                      valueListenable: controller.bookList,
                      builder: (context, bookList, child) {
                        if (bookList == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          width: size.width,
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 20,
                            alignment: WrapAlignment.spaceAround,
                            children: List.generate(
                              bookList.length,
                              (index) => BookBoxWidget(
                                title: bookList[index].title,
                                bookCover: bookList[index].coverUrl,
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

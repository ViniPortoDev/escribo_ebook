import 'dart:io';

import 'package:dio/dio.dart';
import 'package:escribo_ebook/models/ebook_model.dart';
import 'package:escribo_ebook/pages/home_page/home_controller.dart';
import 'package:escribo_ebook/repositories/fetch_books_repository.dart';
import 'package:escribo_ebook/service/dio_service.dart';
import 'package:escribo_ebook/viewmodels/books_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:escribo_ebook/utils/escribo_colors.dart';
import 'package:escribo_ebook/pages/home_page/components/book_box_widget.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

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

  openBook(path, location) async {
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );
    // get current locator
    VocsyEpub.locatorStream.listen((locator) {
      print('LOCATOR: $locator');
    });
    await VocsyEpub.openAsset(
      path,
      lastLocation: EpubLocator.fromJson(location),
      /*
      {
        "bookId": "http://www.gutenberg.org/72134",
        "href": "/OEBPS/5921883067179669558_72134-h-0.htm.xhtml",
        "created": 1702061715408,
        "locations": {"cfi":"epubcfi(/0!/4/6/6/2[pgepubid00000])"},
        "title": ""
      }
      */
    );
  }

  downloadBook(BookModel book) async {
    // FileDownloader.downloadFile(
    //     url: book.downloadUrl,
    //     name: book.title,
    //     notificationType: NotificationType.progressOnly,
    //     onDownloadCompleted: (String path) {
    //       path = 'assets/epubs';

    //       print('FILE DOWNLOADED TO PATH: $path');
    //     });

    // Directory? directory = await getExternalStorageDirectory();

    // if (directory != null) {
    //   String baseDirPath = '${directory.path}/assets/epubs';
    //   print(baseDirPath);

   
    //   // File file = File('$baseDirPath/$fileName');

    //   final dio = Dio();
    //   dio.download(book.downloadUrl, baseDirPath);
    //   book.isDownloaded = true;
    // }
    final bookId = await FlutterDownloader.enqueue(
      url: book.downloadUrl,
      savedDir: 'assets/epubs',
      showNotification:
          true, 
      openFileFromNotification:
          true, 
    );
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
                                isFavorited: bookList[index].isFavorited,
                                isDownloaded: bookList[index].isDownloaded,
                                onTapCover: () async => {
                                  setState(() {
                                    (bookList[index].isDownloaded)
                                        ? openBook("", "")
                                        : downloadBook(
                                            bookList[index],
                                          );
                                  })
                                },
                                onTapFavorite: () {
                                  if (bookList[index].isFavorited) {
                                    setState(() {
                                      bookList[index].unFavorite();
                                    });
                                  } else {
                                    setState(() {
                                      bookList[index].favorite();
                                    });
                                  }
                                },
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

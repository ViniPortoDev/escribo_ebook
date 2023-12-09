import 'package:flutter/material.dart';

class BookBoxWidget extends StatelessWidget {
  final String bookCover;
  final String title;
  bool isFavorited;
  bool isDownloaded;

  final Function()? onTapCover;
  final Function()? onTapFavorite;

  BookBoxWidget({
    super.key,
    required this.bookCover,
    required this.title,
    this.isFavorited = false,
    this.isDownloaded = false,
    this.onTapCover,
    this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            InkWell(
              onTap: onTapCover,
              child: Container(
                height: 120,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(bookCover),
                  ),
                ),
                child: (isDownloaded)
                    ? null
                    : const Icon(
                        Icons.download,
                        size: 32,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
              ),
            ),
            Positioned(
              right: -8,
              top: -4.5,
              child: InkWell(
                onTap: onTapFavorite,
                child: Icon(
                  (isFavorited) ? Icons.bookmark : Icons.bookmark_outline,
                  size: 36,
                  color: (isFavorited)
                      ? Color.fromARGB(255, 240, 63, 63)
                      : Color(0xff383838),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}

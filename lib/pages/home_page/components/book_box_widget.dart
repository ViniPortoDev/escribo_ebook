import 'package:flutter/material.dart';

class BookBoxWidget extends StatelessWidget {
  final String bookCover;
  final String title;
  const BookBoxWidget({
    super.key,
    required this.bookCover,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 120,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(bookCover),
              ),
            ),
            child: const Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  top: -6,
                  child: Icon(
                    Icons.bookmark_outline,
                    size: 36,
                    color: Color(0xff383838),
                  ),
                ),
              ],
            )),
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

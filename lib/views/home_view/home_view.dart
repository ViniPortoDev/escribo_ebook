import 'package:flutter/material.dart';

import 'package:escribo_ebook/utils/escribo_colors.dart';
import 'package:escribo_ebook/views/home_view/widgets/book_box_widget.dart';

import 'widgets/book_toggle_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                  SizedBox(
                    width: size.width,
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 20,
                      alignment: WrapAlignment.spaceAround,
                      children: List.generate(
                        10,
                        (index) => const BookBoxWidget(
                          title: 'Vovó virou semente',
                          bookCover: 'assets/images/capa_1.jpg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

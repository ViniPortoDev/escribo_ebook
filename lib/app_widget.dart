import 'package:flutter/material.dart';

import 'views/home_view/home_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomeView(),
    );
  }
}

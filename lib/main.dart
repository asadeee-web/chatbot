import 'package:chatbot/features/home/home_screen.dart';

import 'package:chatbot/core/utils/pallete.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatbot',
      theme: ThemeData(
        fontFamily: "Cera Pro",
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: AppBarTheme(backgroundColor: Pallete.whiteColor),
      ),
      home: const HomeScreen(),
    );
  }
}

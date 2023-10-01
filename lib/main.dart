import 'package:flutter/material.dart';
import 'package:gameofthrones_app/screens/characterListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Game of Thrones App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF67e6dc),
        accentColor: const Color(0xFFeb4d4b),
        secondaryHeaderColor: const Color(0xFF222f3e),
        backgroundColor: const Color(0xFFfc5c65),
      ),
      home: const characters(),
    );
  }
}

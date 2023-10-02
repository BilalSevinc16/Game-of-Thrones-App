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
        scaffoldBackgroundColor: const Color(0xff171f1f),
        secondaryHeaderColor: const Color(0xff5d7191),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(
              background: const Color(0xff5e4d50),
            )
            .copyWith(
              secondary: const Color(0xff312828),
            ),
      ),
      home: const GoTCharacters(),
    );
  }
}

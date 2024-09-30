import 'package:flutter/material.dart';
import 'package:pr4_appmania/views/screens/detailpage.dart';
import 'package:pr4_appmania/views/screens/favourite.dart';
import 'package:pr4_appmania/views/screens/homepage.dart';
import 'package:pr4_appmania/views/screens/mealpage.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Homepage(),
        'detail_page': (context) => const Detailpage(),
        'favourite_page': (context) => const FavouritePage(),
        'meal_page': (context) => const Mealpage(),
      },
    );
  }
}

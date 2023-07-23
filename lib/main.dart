import 'package:flutter/material.dart';
import 'package:movie_app/pages/Mainpage.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/pages/splash_screen_page.dart';
import 'package:movie_app/provider/api_provider.dart';
import 'package:provider/provider.dart';

import 'components/navigation_obeserver/navigation_obeserver.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        CustomNavigatorObserver(context),
      ],
      home: const MainPage(),
    );
  }
}

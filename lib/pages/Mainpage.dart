import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/pages/explore_page.dart';
import 'package:movie_app/pages/setting_page.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

import 'favorite_page.dart';
import 'home_page.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  final List<Widget> page = [
    const HomePage(),
    const ExplorePage(),
    const FavoritePage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: backgroundColor.withOpacity(1.0),
          body: page[pageIndex],
          bottomNavigationBar:Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
            vertical: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade700.withOpacity(0.5),
                      Colors.blue.withOpacity(0.5),
                    ])
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                child: GNav(
                  color: backgroundColor,
                  hoverColor: Colors.transparent,
                  rippleColor: Colors.transparent,
                  tabMargin: const EdgeInsets.all(3),
                  gap: 9,
                  onTabChange: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  selectedIndex: pageIndex,
                  activeColor: Colors.blue,
                  iconSize: 32,
                  padding: const EdgeInsets.all(13),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: "Home",
                    ),
                    GButton(
                      icon: Icons.search,
                      text: "Explore",
                    ),
                    GButton(
                      icon: Icons.bookmark,
                      text: "Favorite",
                    ),
                    GButton(
                      icon: Icons.person,
                      text: "Account",
                    ),
                  ],
                ),
              ),
            ),
          )
    );
  }
}

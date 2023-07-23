import 'package:flutter/material.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text(
          "settings",
          style: TextStyle(color: Colors.white, fontSize: 45),
        ),
      ),
    );
  }
}

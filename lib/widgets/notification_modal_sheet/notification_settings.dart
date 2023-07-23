import 'package:flutter/material.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

import 'notification_toggle_button.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Set up your Notification",
          style: TextStyle(
              fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Get Updates on the following category of movies",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),
              const ToggleButton(title: "Upcoming Movies",
              content: "Get updates on upcoming movies",),
              const ToggleButton(title: "Upcoming Movies",
                content: "Get updates on upcoming movies",),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final BuildContext dialogContext;

  CustomNavigatorObserver(this.dialogContext);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == '/top_rated_page' ||
        previousRoute?.settings.name == '/top_rated_page') {
      Navigator.of(dialogContext).pop();
    }
  }
}

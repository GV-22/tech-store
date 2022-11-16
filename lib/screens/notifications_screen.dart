import 'package:flutter/material.dart';
import 'package:responsive_app/widgets/notifications.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = "/notifications";

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: const Notifications(),
    );
  }
}

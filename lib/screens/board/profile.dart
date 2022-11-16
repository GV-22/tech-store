import 'package:flutter/material.dart';
import 'package:responsive_app/utils/ui.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        right: isMobile ? 0 : 24,
        left: isMobile ? 0 : 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 24 : 36,
            ),
          ),
        ],
      ),
    );
  }
}

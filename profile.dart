import 'package:flutter/material.dart';
import 'package:thireyeapp/pages/logout.dart';
import 'package:thireyeapp/pages/settings.dart';
import 'package:thireyeapp/pages/spects.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String deviceId;

  ProfilePage({required this.email, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Logout icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogoutPage()), // Navigate to logout page
              );
            },
          ),
           IconButton(
            icon: Icon(Icons.home), // Logout icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()), // Navigate to logout page
              );
            },
          ),
           IconButton(
            icon: Icon(Icons.settings), // Logout icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()), // Navigate to logout page
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.person, size: 50), // Person icon
            ),
            SizedBox(height: 20),
            
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 30), // Email icon
                SizedBox(width: 10),
                Text(
                  'Email: $email',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.device_hub, size: 30), // Device icon
                SizedBox(width: 10),
                Text(
                  'Device ID: $deviceId',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

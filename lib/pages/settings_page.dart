// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, use_key_in_widget_constructors, avoid_print, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'LoginPage.dart';
import 'profile_page.dart';
import 'RatingPage.dart';

class SettingsPage extends StatelessWidget {
  void _logout(BuildContext context) {
    Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0;
        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        );
        return ScaleTransition(
          scale: tween.animate(curvedAnimation),
          child: child,
        );
      },
    ),
  );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _navigateToRating(BuildContext context) async {
    final selectedRating = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingPage()),
    );







    
    if (selectedRating != null) {
      print('User rated the app with $selectedRating stars');
    }
  }

void _contactUs(BuildContext context) async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'assiabk526@gmail.com',
    queryParameters: {
      'subject': 'Regarding your app',
      'body': 'Write your message here...',
    },
  );

  final String emailUri = _emailLaunchUri.toString();

  if (await canLaunch(emailUri)) {
    await launch(emailUri);
  } else {
 
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Email App'),
        content: Text('There is no email app available on your device.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BK_Services',
          style: TextStyle(
            color: const Color(0xFFB6BBC4),
          ),
        ),
        backgroundColor: Color(0xFF161A30),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFF0ECE5)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFF161A30),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Container(
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB6BBC4),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            _navigateToProfile(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: const [
                                Icon(Icons.person,
                                    size: 30, color: Color(0xFF161A30)),
                                SizedBox(width: 10),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.notifications_active_outlined,
                                  size: 30, color: Color(0xFF161A30)),
                              SizedBox(width: 10),
                              Text(
                                'Notification',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () {
                              _navigateToRating(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.feedback_rounded,
                                    size: 30, color: Color(0xFF161A30)),
                                SizedBox(width: 10),
                                Text(
                                  'Feedback',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB6BBC4),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () {
                              _contactUs(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.mail,
                                    size: 30, color: Color(0xFF161A30)),
                                SizedBox(width: 10),
                                Text(
                                  'Contact us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.logout,
                                  size: 30, color: Color(0xFF161A30)),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => _logout(context),
                                child: Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

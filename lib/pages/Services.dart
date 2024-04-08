// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_local_variable, unused_field, file_names
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'electrecians_page.dart';
import 'plumbers_page.dart';
import 'settings_page.dart';
import 'technicians_page.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161A30),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161A30),
        automaticallyImplyLeading: false,
        title: const Text(
          'BK_Services',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xFFF0ECE5),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFB6BBC4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BK_Services',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: const Color(0xFF161A30),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Streamlining the\nsearch for qualified professionals',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(255, 119, 122, 141),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => TechniciansPage(),
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
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF161A30), backgroundColor: const Color(0xFFB6BBC4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Technicians',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => ElectreciansPage(),
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
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF161A30), backgroundColor: const Color(0xFFB6BBC4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Electrecians',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => PlumbersPage(),
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
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF161A30), backgroundColor: const Color(0xFFB6BBC4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Plumbers',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFFB6BBC4),
        backgroundColor: Color(0xFF161A30),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.star, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Handle button tap
          switch (index) {
            case 0:
              Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => Services(),
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
              break;
            // case 1:
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => favorite_Page()),
            //   );
            //   break;
            case 2:
              Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
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
              break;
          }
        },
      ),
    );
  }
}

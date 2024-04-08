// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'LoginPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161A30),
      body: Stack(
        children: [
          Center(
            child: Text(
              'Bk_Services',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 42.0,
                color: Color(0xFFF0ECE5),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: GestureDetector(
              onTap: () {
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

              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB6BBC4),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFFF0ECE5),
                ),


                 
              ),
            ),
          ),
        ],
      ),
    );
  }
}

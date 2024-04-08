// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class favorite_Page extends StatefulWidget {
  const favorite_Page({super.key});

  @override
  State<favorite_Page> createState() => _favorite_PageState();
}

class _favorite_PageState extends State<favorite_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'BK_Services',
          style: TextStyle(
            color: Color(0xFFF0ECE5),
          ),
        ),
        backgroundColor: Color(0xFF161A30),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFF0ECE5),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Container(
      color: Color(0xFF161A30),
     child:SafeArea(
      child: Center(

      ),
      ),
      ),
     
    );
  }
}
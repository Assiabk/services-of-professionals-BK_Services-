// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int selectedRating = 0;

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedRating = index;
        });
      },
      icon: Icon(
        index <= selectedRating ? Icons.star : Icons.star_border,
        color: Colors.amber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161A30),
        title: Text(
          'Rate the App',
          style: TextStyle(color: Colors.white),
        ),
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
      body: Container(
        color: Color(0xFFB6BBC4),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please rate the app:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index + 1)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the rating to Firestore
                  // You can add the Firestore saving logic here
                  Navigator.pop(context, selectedRating); // Return the selected rating to the previous page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF161A30),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

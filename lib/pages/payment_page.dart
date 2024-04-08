// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(
            color: Color(0xFFB6BBC4),
          ),
        ),
        backgroundColor: Color(0xFF161A30),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFB6BBC4),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF161A30),
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xFFB6BBC4),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 192, 189, 189).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Payment Details',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF161A30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Simulate successful payment
                    _showPaymentResult(context, true);
                  },
                  child: Text('Pay Now'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Simulate failed payment
                    _showPaymentResult(context, false);
                  },
                  child: Text('Cancel Payment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentResult(BuildContext context, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment ${success ? 'Successful' : 'Failed'}'),
          content: Text(success ? 'Thank you for your payment!' : 'Payment failed. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  LocationPage({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps WebView'),
      ),
      body: WebView(
        initialUrl: 'https://www.google.com/maps?q=$latitude,$longitude',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

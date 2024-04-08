// ignore_for_file: prefer_const_constructors, await_only_futures

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _currentUser;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_currentUser != null) {
      if (_currentUser!.displayName == null && _currentUser!.providerData.isNotEmpty) {
        var user = await FirebaseAuth.instance.currentUser!;
        setState(() {
          _username = user.displayName ?? '';
        });
      } else {
        setState(() {
          _username = _currentUser!.displayName ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF161A30),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0xFF161A30),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  _currentUser?.photoURL ?? 'https://via.placeholder.com/150',
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Username: $_username',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${_currentUser?.email ?? "N/A"}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
             
            ],
          ),
        ),
      ),
    );
  }
}

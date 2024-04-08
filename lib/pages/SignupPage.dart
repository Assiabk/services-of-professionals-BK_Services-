// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'Services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161A30),
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          color: const Color(0xFF161A30),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: const Icon(
                        Icons.lock,
                        size: 100.0,
                        color: Color(0xFFF0ECE5),
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Welcome! Thrilled to have you join us',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF0ECE5),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField('Username', 'YourUsername', _usernameController),
                          SizedBox(height: 14),
                          _buildTextField('Email', 'aaa@gmail.com', _emailController),
                          SizedBox(height: 14),
                          _buildPasswordTextField(),
                          SizedBox(height: 14),
                        ],
                      ),
                    ),
                    _buildSignupButton(context),
                    _buildOrDivider(context),
                    _buildGoogleSignupButton(context),
                    SizedBox(height: 20),
                    FadeTransition(
                      opacity: _animation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member?',
                            style: TextStyle(
                              color: Color(0xFFF0ECE5),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 600),
                                  pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    var begin = 0.0;
                                    var end = 1.0;
                                    var tween = Tween(begin: begin, end: end);
                                    var curvedAnimation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    );
                                    return ScaleTransition(
                                      scale: tween.animate(curvedAnimation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Login Here',
                              style: TextStyle(
                                color: Color(0xFFB6BBC4),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
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
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hintText, TextEditingController controller) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFB6BBC4),
            ),
          ),
          SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF0ECE5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xFFB6BBC4),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Color(0xFFB6BBC4),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(
              color: Color(0xFFB6BBC4),
            ),
          ),
          SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF0ECE5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(
                color: Color(0xFFB6BBC4),
              ),
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  color: Color(0xFFB6BBC4),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFFB6BBC4),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Password must contain at least 6 characters, including letters and numbers.',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 370,
        child: ElevatedButton(
          onPressed: () async {
            String username = _usernameController.text.trim();
            String email = _emailController.text.trim();
            String password = _passwordController.text;

            if (password.length >= 6 && password.contains(RegExp(r'[0-9]')) && password.contains(RegExp(r'[a-zA-Z]'))) {
              try {
                UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                await userCredential.user?.updateDisplayName(username);

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
              } on FirebaseAuthException catch (e) {
                print('Failed with error code: ${e.code}');
                print(e.message);
              }
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Password Error'),
                    content: Text('Password must contain at least 6 characters, including letters and numbers.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFFF0ECE5),
            backgroundColor: Color(0xFFB6BBC4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Color(0xFF31304D),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: Color(0xFFB6BBC4),
                    thickness: 0.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Color(0xFFB6BBC4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: Color.fromRGBO(182, 187, 196, 1),
                    thickness: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGoogleSignupButton(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        onTap: () async {
          try {
            final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['profile', 'email']).signIn();
            final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            await _auth.signInWithCredential(credential);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Services()));
          } catch (e) {
            print(e);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Image(
            image: AssetImage('lib/images/google.png'),
            height: 50,
            width: 100,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

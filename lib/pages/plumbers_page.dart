// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'Services.dart';
import 'addplumber.dart';
import 'payment_page.dart';
import 'settings_page.dart';

class PlumbersPage extends StatefulWidget {
  @override
  _PlumbersPageState createState() => _PlumbersPageState();
}

class _PlumbersPageState extends State<PlumbersPage> {
  List<String> favoritedPlumbers = [];

  void _toggleFavorite(String plumberFullName) {
    setState(() {
      if (favoritedPlumbers.contains(plumberFullName)) {
        favoritedPlumbers.remove(plumberFullName);
      } else {
        favoritedPlumbers.add(plumberFullName);
      }
    });
  }

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Color(0xFFF0ECE5),
            ),
            onPressed: () {
                 Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>AddPlumbersPage(),
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
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF161A30),
        child: SafeArea(
          child: Center(
            child: PlumberContainer(
              toggleFavorite: _toggleFavorite,
              favoritedPlumbers: favoritedPlumbers,
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFFB6BBC4),
        backgroundColor: Color(0xFF161A30),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>  Services(),
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
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
              break;
            case 1:
  List<Map<String, dynamic>> favoritedPlumbersData = [];
  FirebaseFirestore.instance.collection('new_plumbers').get().then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      var plumberData = doc.data();
      if (favoritedPlumbers.contains(plumberData['NewFullName'])) {
        favoritedPlumbersData.add(plumberData);
      }
    });
     Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>FavoritePlumbersPage(favoritedPlumbersData),
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
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
  });
  break;

            case 2:
              Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>SettingsPage(),
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
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
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

class PlumberContainer extends StatelessWidget {
  final List<String> favoritedPlumbers;
  final Function(String) toggleFavorite;

  const PlumberContainer({
    required this.favoritedPlumbers,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('new_plumbers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No Plumbers Available');
        }

        var plumbers = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.only(top: 46),
          child: Column(
            children: plumbers.map((QueryDocumentSnapshot<Map<String, dynamic>> plumber) {
              var plumberData = plumber.data();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => PlumberDetailsPage(plumberData),
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
                  width: 350,
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB6BBC4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          plumberData['NewFullName'] ?? 'N/A',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: const Color(0xFF161A30),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            toggleFavorite(plumberData['NewFullName']);
                          },
                          child: Icon(
                            favoritedPlumbers.contains(plumberData['NewFullName'])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Color(0xFF161A30),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
class FavoritePlumbersPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoritedPlumbersData;

  const FavoritePlumbersPage(this.favoritedPlumbersData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161A30),
        title: Text(
          'Favorite Plumbers',
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
        color: Color(0xFF161A30),
        child: favoritedPlumbersData.isEmpty
            ? Center(
                child: Text(
                  'No favorite plumbers',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: favoritedPlumbersData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Color(0xFFB6BBC4),
                      child: ListTile(
                        title: Text(
                          favoritedPlumbersData[index]['NewFullName'] ?? 'N/A',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    
                        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF161A30) ),
                        onTap: () {
                           Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>PlumberDetailsPage(favoritedPlumbersData[index]),
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
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}


class PlumberDetailsPage extends StatelessWidget {
  final Map<String, dynamic> plumberData;

  const PlumberDetailsPage(this.plumberData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          plumberData['NewFullName'] ?? 'Plumbers Details',
          style: TextStyle(
            color: Color(0xFFB6BBC4),
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
      body: Container(
        color: const Color(0xFF161A30),
        child: Center(
          child: Container(
            height: 500,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xFFB6BBC4),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
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
                Column(
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF161A30),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${plumberData['NewAddress'] ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF161A30),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF161A30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${plumberData['NewContact'] ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF161A30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>PaymentPage(),
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
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                  },
                  child: const Text(
                    'Reserve',
                    style: TextStyle(
                      color: Color(0xFFB6BBC4),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF161A30),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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

void main() {
  runApp(MaterialApp(
    home: PlumbersPage(),
  ));
}

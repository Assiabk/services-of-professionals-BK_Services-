// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'LocationPage.dart';
import 'Services.dart';
import 'addelectrecian.dart';
import 'payment_page.dart';
import 'settings_page.dart';

class ElectreciansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Set<String> favoritedElectrecians = {}; // Define favoritedElectrecians here

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
                      pageBuilder: (context, animation, secondaryAnimation) =>AddElectrecianPage(),
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
            child: ElectrecianContainer(favoritedElectrecians), // Pass favoritedElectrecians to ElectrecianContainer
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
                Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryAnimation) => Services(),
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
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryAnimation) => FavoriteElectreciansPage(favoritedElectrecians),
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
            case 2:
             Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
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
           } ),
             );
              break;
          }
        },
      ),
    );
  }
}

class ElectrecianContainer extends StatefulWidget {
  final Set<String> favoritedElectrecians; // Receive favoritedElectrecians as a parameter

  ElectrecianContainer(this.favoritedElectrecians);

  @override
  _ElectrecianContainerState createState() => _ElectrecianContainerState();
}

class _ElectrecianContainerState extends State<ElectrecianContainer> {
  void _toggleFavorite(String electrecianId) {
    setState(() {
      if (widget.favoritedElectrecians.contains(electrecianId)) {
        widget.favoritedElectrecians.remove(electrecianId);
      } else {
        widget.favoritedElectrecians.add(electrecianId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('new_electricians').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No Electrecians Available');
        }

        var electrecians = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.only(top: 46),
          child: Column(
            children: electrecians.map((QueryDocumentSnapshot<Map<String, dynamic>> electrecian) {
              var electrecianData = electrecian.data();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => ElectrecianDetailsPage(electrecianData),
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
                          electrecianData['NewFullName'] ?? 'N/A',
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
                            _toggleFavorite(electrecian.id);
                          },
                          child: Icon(
                            widget.favoritedElectrecians.contains(electrecian.id)
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

class FavoriteElectreciansPage extends StatelessWidget {
  final Set<String> favoritedElectrecians;

  const FavoriteElectreciansPage(this.favoritedElectrecians);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161A30),
        title: Text(
          'Favorite Electrecians',
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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('new_electricians').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No Electrecians Available'));
            }

            var electrecians = snapshot.data!.docs;

            var favoritedElectreciansData = electrecians.where((electrecian) =>
                favoritedElectrecians.contains(electrecian.id)).toList();

            if (favoritedElectreciansData.isEmpty) {
              return Center(
                child: Text(
                  'No favorite electrecians',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: favoritedElectreciansData.length,
              itemBuilder: (context, index) {
                var electrecianData = favoritedElectreciansData[index].data();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: Color(0xFFB6BBC4),
                    child: ListTile(
                      title: Text(
                        electrecianData['NewFullName'] ?? 'N/A',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF161A30)),
                      onTap: () {
                        Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => ElectrecianDetailsPage(electrecianData),
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
            );
          },
        ),
      ),
    );
  }
}
class ElectrecianDetailsPage extends StatelessWidget {
  final Map<String, dynamic> electrecianData;

  const ElectrecianDetailsPage(this.electrecianData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          electrecianData['NewFullName'] ?? 'Electrecian Details',
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
                      '${electrecianData['NewAddress'] ?? 'N/A'}',
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
                  '${electrecianData['NewContact'] ?? 'N/A'}',
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
                    var location =electrecianData['location'];

                    if (location != null && location is GeoPoint) {
                      double latitude = location.latitude;
                      double longitude = location.longitude;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationPage(
                            latitude: latitude,
                            longitude: longitude,
                          ),
                        ),
                      );
                    } else {
                      print('Invalid or missing location data');
                    }
                  },
                  child: const Text(
                    'Show Location',
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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

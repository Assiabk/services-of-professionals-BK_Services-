
 // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_collection_literals, library_private_types_in_public_api, avoid_print
 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'LocationPage.dart';
import 'Services.dart';
import 'addtechnician.dart';
import 'payment_page.dart';
import 'settings_page.dart';

class TechniciansPage extends StatelessWidget {
  final Set<String> favoritedTechnicians = Set<String>();

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
                      pageBuilder: (context, animation, secondaryAnimation) =>AddTechnicianPage(),
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
            child: TechnicianContainer(favoritedTechnicians: favoritedTechnicians),
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
                  pageBuilder: (context, animation, secondaryAnimation) => FavoriteTechniciansPage(favoritedTechnicians),
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

class TechnicianContainer extends StatefulWidget {
  final Set<String> favoritedTechnicians;

  const TechnicianContainer({required this.favoritedTechnicians});

  @override
  _TechnicianContainerState createState() => _TechnicianContainerState();
}

class _TechnicianContainerState extends State<TechnicianContainer> {
  void _toggleFavorite(String technicianId) {
    setState(() {
      if (widget.favoritedTechnicians.contains(technicianId)) {
        widget.favoritedTechnicians.remove(technicianId);
      } else {
        widget.favoritedTechnicians.add(technicianId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('new_technicians').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No Technicians Available');
        }

        var technicians = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.only(top: 46),
          child: Column(
            children: technicians.map((QueryDocumentSnapshot<Map<String, dynamic>> technician) {
              var technicianData = technician.data();

                  return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => TechnicianDetailsPage(technicianData),
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
                          technicianData['NewFullName'] ?? 'N/A',
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
                            _toggleFavorite(technician.id);
                          },
                          child: Icon(
                            widget.favoritedTechnicians.contains(technician.id)
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


class FavoriteTechniciansPage extends StatelessWidget {
  final Set<String> favoritedTechnicians;

  const FavoriteTechniciansPage(this.favoritedTechnicians);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161A30),
        title: Text(
          'Favorite Technicians',
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
          stream: FirebaseFirestore.instance.collection('new_technicians').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No Technicians Available'));
            }

            var technicians = snapshot.data!.docs;

            var favoritedTechniciansData = technicians.where((technician) =>
              favoritedTechnicians.contains(technician.id)
            ).toList();

            if (favoritedTechniciansData.isEmpty) {
              return Center(
                child: Text(
                  'No favorite technicians',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: favoritedTechniciansData.length,
              itemBuilder: (context, index) {
                var technicianData = favoritedTechniciansData[index].data();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: Color(0xFFB6BBC4),
                    child: ListTile(
                      title: Text(
                        technicianData['NewFullName'] ?? 'N/A',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF161A30)),
                      onTap: () {
                         Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => TechnicianDetailsPage(technicianData),
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
 

 class TechnicianDetailsPage extends StatelessWidget {
   final Map<String, dynamic> technicianData;

   const TechnicianDetailsPage(this.technicianData);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(
           technicianData['NewFullName'] ?? 'Technician Details',
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
       '${technicianData['NewAddress'] ?? 'N/A'}',
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
 )
 ,
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
       '${technicianData['NewContact'] ?? 'N/A'}',
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
                    var location = technicianData['location'];

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
        
         )
         ,
         style: ElevatedButton.styleFrom(
           backgroundColor: Color(0xFF161A30),
           shape:  BeveledRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(10))),
              
           ),
       ),
   ],
 ), 
 ),
         )
         )
         );
         
   }
 }
 



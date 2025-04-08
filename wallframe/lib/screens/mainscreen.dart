import 'package:flutter/material.dart';
import 'package:wallframe/screens/categoriesscreen.dart';
import 'package:wallframe/screens/homescreen.dart';
import 'package:wallframe/screens/profilescreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  var selectedindex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Homescreen(),
    const Categoriesscreen(),
    // const Likedscreens(),
    const ProfileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[selectedindex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),  // Transparent background for the curve
        color: Colors.black,                  // Background color of the nav bar
        height: 60,                           // Height of the nav bar
        animationDuration: const Duration(milliseconds: 300), // Animation speed
        animationCurve: Curves.easeInOut,     // Smooth curve for the transition
        index: selectedindex,                 // Set the default selected index
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: selectedindex == 0 ? Colors.blue[300] : Colors.white,  // Change color to blue if selected
          ),
          Icon(
            Icons.category_rounded,
            size: 30,
            color: selectedindex == 1 ? Colors.blue[300] : Colors.white,  // Change color to blue if selected
          ),
          // Icon(
          //   Icons.favorite_rounded,
          //   size: 30,
          //   color: selectedindex == 2 ? Colors.blue[300] : Colors.white,  // Change color to blue if selected
          // ),
          Icon(
            Icons.person,
            size: 30,
            color: selectedindex == 2 ? Colors.blue[300] : Colors.white,  // Change color to blue if selected
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedindex = index; // Update the selected index
          });
        },
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkTheme = true;

  void toggleTheme(bool isDark) {
    setState(() {
      isDarkTheme = isDark;
      print(isDarkTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        // elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        
        decoration: const BoxDecoration(
          
          color: Color.fromARGB(255, 29, 29, 29),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Header with Picture and Welcome Text
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 250,
                    child: Image.asset("assets/images/banner600.jpg"),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.contact_mail, color: Colors.blue),
                        title: const Text(
                          'Contact Developer',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                           await launchUrl(Uri.parse("mailto:shivambari2728@gmail.com"));
                        },
                      ),
                      //const Divider(color: Colors.grey),
                      ListTile(
                        leading: const Icon(Icons.telegram_rounded,
                            color: Colors.blue),
                        title: const Text(
                          'Telegram',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                           await launchUrl(Uri.parse('https://t.me/ShivamTheSkywalker'));
                        },
                      ),
                      //const Divider(color: Colors.grey),
                      ListTile(
                        leading: const Icon(Icons.code, color: Colors.blue),
                        title: const Text(
                          'GitHub',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                           await launchUrl(Uri.parse('https://github.com/ShivamBari2728'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:wallframeadmin/firebase_options.dart';
import 'package:wallframeadmin/homescreen.dart'; // Import HomeScreen
import 'package:wallframeadmin/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallframe Admin',
      theme: ThemeData.dark(), // Use a dark theme
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), // Listen to auth state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            // Navigate to HomeScreen if the user is logged in
            if (user != null) {
              return const HomeScreen();
            }
            // Otherwise, show the LoginScreen
            return const LoginScreen();
          }
          // While checking authentication state, show a loading indicator
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

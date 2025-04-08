// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wallframeadmin/loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isUploading = false;
  String? _downloadUrl;
  final TextEditingController _titleController = TextEditingController();

  Future<void> pickAndUploadImage() async {
    // Validate that the title input is not empty
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the wallpaper')),
      );
      return; // Exit the function if the input is invalid
    }

    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final fileName = result.files.single.name; // Get default file name

      setState(() {
        _isUploading = true;
      });

      try {
        // Upload to Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child('images/$fileName');
        await storageRef.putFile(file);

        // Get download URL
        final downloadUrl = await storageRef.getDownloadURL();

        // Save URL and title to Firestore
        await FirebaseFirestore.instance.collection('wallpapers').add({
          'url': downloadUrl,
          'name': fileName,
          'category': _titleController.text
              .trim(), // Use the input as the wallpaper title
          'uploadedAt': Timestamp.now(),
        });

        setState(() {
          _isUploading = false;
          _downloadUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload successful!')),
        );
      } catch (e) {
        setState(() {
          _isUploading = false;
        });
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.logout_rounded),
            ),
          ),
        ],
        title: const Text(
          'Welcome',
          style: TextStyle(fontSize: 17, fontFamily: "Inter"),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/background3.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 1),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: _isUploading
                      ? const Center(child: CircularProgressIndicator())
                      : _downloadUrl != null
                          ? Center(
                              child: Image(
                                image: NetworkImage(_downloadUrl!),
                                fit: BoxFit.fill,
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                "assets/images/mainlogo.png",
                                height: 125,
                                fit: BoxFit.contain,
                              ),
                            ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Text field for wallpaper title input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Enter the wallpaper category',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      filled: true,
                      fillColor: Color.fromARGB(110, 0, 0, 0),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 45,
                  width: 225,
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : pickAndUploadImage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: _isUploading
                        ? const Text("Uploading...")
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_rounded),
                              SizedBox(width: 5),
                              Text("Upload wallpaper",
                                  style: TextStyle(fontFamily: "Inter")),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WallpaperProvider with ChangeNotifier {
  List<Map<String, dynamic>> wallpaperData = [];


  Future<void> fetchData() async {
    
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('wallpapers');
      QuerySnapshot querySnapshot = await collectionRef.orderBy("uploadedAt",descending: true).get();
       wallpaperData.clear();
      for (var doc in querySnapshot.docs) {
        wallpaperData.add(doc.data() as Map<String, dynamic>);
        
      }
      print(wallpaperData);
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}

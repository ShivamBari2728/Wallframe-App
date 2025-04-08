import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:wallframe/provider/wallpaperprovider.dart';
import 'package:wallframe/screens/categoriespecificscreen.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen> {
  bool isloading = false;
  List<Map<String, dynamic>> categoryImages = [];

  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });

    await Provider.of<WallpaperProvider>(context, listen: false).fetchData();

     try {
    final response = await Dio().get(
      'https://raw.githubusercontent.com/ShivamBari2728/wallframeData/main/wallpapercatogorys.json',
      options: Options(responseType: ResponseType.plain), 
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.data);
      categoryImages =
          List<Map<String, dynamic>>.from(decodedJson); 
    } else {
      debugPrint("Error loading category data: ${response.statusCode}");
    }
  } catch (e) {
    debugPrint(" Error fetching category data: $e");
  }

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final wallpapers = Provider.of<WallpaperProvider>(context).wallpaperData;
    final categoriesSet =
        wallpapers.map((wallpaper) => wallpaper['category'] as String).toSet();
    final categories = categoriesSet.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Category",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchData,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 29, 29, 29),
                ),
                child: categories.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          final imageUrl = categoryImages.firstWhere(
                            (element) => element["category"] == category,
                            orElse: () => {"category": category, "url": ""},
                          )["url"]!;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Categoriespecificscreen(Title: category),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Hero(
                                      tag: 'category_${category}_title',
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl,
                                        placeholder: (context, url) =>
                                            const LinearProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.blue),
                                          minHeight: 0.1,
                                        ),
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: double.infinity,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    Hero(
                                      tag: 'category_${category}_title',
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
    );
  }
}

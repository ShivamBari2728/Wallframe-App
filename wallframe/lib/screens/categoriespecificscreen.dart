import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallframe/provider/wallpaperprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallframe/screens/wallpaperviewpage.dart';

class Categoriespecificscreen extends StatefulWidget {
  final String Title;
  const Categoriespecificscreen({super.key, required this.Title});

  @override
  State<Categoriespecificscreen> createState() => _CategoriespecificscreenState();
}

class _CategoriespecificscreenState extends State<Categoriespecificscreen> {
  @override
  Widget build(BuildContext context) {
    // Access the wallpaper data from the provider
    final wallpapers = Provider.of<WallpaperProvider>(context).wallpaperData;

    // Filter the wallpapers based on the category name passed to the screen
    final categoryWallpapers = wallpapers
        .where((wallpaper) => wallpaper['category'] == widget.Title)
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Hero(
          tag: 'category_${widget.Title}_title',
          child: Text(
            widget.Title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: categoryWallpapers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ) // Show loading if no data
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 200,
                ),
                itemCount: categoryWallpapers.length,
                itemBuilder: (context, index) {
                  final wallpaper = categoryWallpapers[index];
                  final imageUrl = wallpaper['url'];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Wallpaperviewpage(
                              imagename: categoryWallpapers[index]["category"]!,
                              imageUrl: categoryWallpapers[index]["url"]!,
                              tag: 'image_${categoryWallpapers[index]}', // Pass tag correctly
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'image_${categoryWallpapers[index]}', // Ensure tag matches the destination Hero widget
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                                color: Colors.blue), // Loading spinner
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red, // Show error icon on failure
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class Wallpaperviewpage extends StatefulWidget {
  final String imageUrl;
  final String tag;
  final String imagename;

  const Wallpaperviewpage(
      {super.key,
      required this.imageUrl,
      required this.tag,
      required this.imagename});

  @override
  State<Wallpaperviewpage> createState() => _WallpaperviewpageState();
}

class _WallpaperviewpageState extends State<Wallpaperviewpage> {
  int _width = 0;
  int _height = 0;

  @override
  void initState() {
    super.initState();
     _getImageResolution();
  }

  void _getImageResolution() async {
    final Image image = Image.network(widget.imageUrl);

    final ImageStream imageStream =
        image.image.resolve(const ImageConfiguration());
    imageStream.addListener(
        ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
      setState(() {
        _width = imageInfo.image.width;
        _height = imageInfo.image.height;
      });
    }));
  }

  final WallpaperManagerPlus wallpaperManagerPlus = WallpaperManagerPlus();

  Future<void> _setwallpaper(location) async {
    final file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    try {
      final result = await wallpaperManagerPlus.setWallpaper(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          content: Text(result ?? ' Wallpaper updated'),

        ),
      );
      Navigator.pop(context);
          print("done");
      // Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error Setting Wallpaper'),
        ),
      );
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Inter', fontSize: 18)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Hero(
                tag: widget.tag,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20),
                   // Adjust the radius as needed
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(15),
              color: Colors.black.withOpacity(0.9),
              child: Center(
                child: Column(
                  children: [
                    Column(
                      spacing: 5,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.category_rounded),
                            Text("  ${widget.imagename}",
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.wallpaper_rounded),
                            _width == 0 && _height == 0
                                ? const Text(
                                    "  Loading...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                    ),
                                  )
                                : Text(
                                    "  $_width x $_height",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0)),
                          ),
                          backgroundColor: Colors.black,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),

                                  // Top row with two icon buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () {
                                             _setwallpaper(WallpaperManagerPlus.homeScreen);
                                          },
                                          icon: const Icon(
                                            Icons.home,
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            "Home Screen",
                                            style: TextStyle(
                                                //fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'Inter'),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                          )),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            _setwallpaper(WallpaperManagerPlus.lockScreen);
                                          },
                                          icon: const Icon(
                                            Icons.lock,
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            "lock Screen",
                                            style: TextStyle(
                                                //fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'Inter'),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                          )),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  // Set Both button with icon
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        _setwallpaper(WallpaperManagerPlus.bothScreens);
                                      },
                                      icon: const Icon(
                                        Icons.wallpaper_rounded,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        "Both",
                                        style: TextStyle(
                                            //fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: 'Inter'),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 40),
                                      )),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.download, color: Colors.black),
                      label: const Text(
                        "Set Wallpaper",
                        style: TextStyle(
                            //fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Inter'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

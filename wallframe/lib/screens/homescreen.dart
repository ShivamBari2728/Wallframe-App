// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallframe/provider/wallpaperprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'wallpaperviewpage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });
    await Provider.of<WallpaperProvider>(context, listen: false).fetchData();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallpapers = Provider.of<WallpaperProvider>(context).wallpaperData;
    print(wallpapers);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover",
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
          ? Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 29, 29, 29),
              ),
              child: const Center(child: CircularProgressIndicator(color: Colors.blue,)))
          : RefreshIndicator(
              onRefresh: fetchData,
              child: Container(
                color: const Color.fromARGB(255, 29, 29, 29),
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: GridView.builder(
                    cacheExtent: 300,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 300, 
                    ),
                    physics:
                        const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: wallpapers.length,
                    itemBuilder: (context, index) {
                      // Unique Hero tag for each image
                      String heroTag = "wallpaper_${index}";

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Wallpaperviewpage(
                                imagename: wallpapers[index]["category"]!,
                                imageUrl: wallpapers[index]["url"]!,
                                tag: heroTag,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: heroTag,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: CachedNetworkImage(
                                            imageUrl: wallpapers[index]["url"]!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(color: Colors.blue,),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                wallpapers[index]["category"]!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: "Inter",
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
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
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

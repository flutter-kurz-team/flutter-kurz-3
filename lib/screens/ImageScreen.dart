import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../components/components.dart';
import '../components/imageListItem.dart';


class ImageScreen extends StatefulWidget {
  ImageScreen({Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  SharedPreferences _prefs;
  bool started = false;

  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      started = true;
      print("Nastartováno");
    });
  }

  Future<List> getListOfImages() async {
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }

    return _prefs.getStringList("IMAGES_PATHS") ?? [];
  }

  void removeImage(int index) async {
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }
    List<String> ideas = _prefs.getStringList("IMAGES_PATHS");

    String pathToRemove = ideas[index];
    File fileToDelete = File(pathToRemove);
    try {
      await fileToDelete.delete();
      ideas.removeAt(index);
    } catch (e) {
      print(e);
    }

    _prefs.setStringList("IMAGES_PATHS", ideas);
    _prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop: () async => false,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Fotky"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notes),
            onPressed: () => Navigator.pushNamed(context, "/second"),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => Navigator.pushNamed(context, "/camera"),
          ),
          IconButton(
            icon: const Icon(Icons.notes),
            onPressed: () => Navigator.pushNamed(context, "/")
          )
        ],
      ),
      drawer: Components().getDrawer(context),
      drawerScrimColor: Colors.green,
      body: Center(
        child: FutureBuilder(
            future: getListOfImages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final img in snapshot.data)
                        ImageListItem(
                          fileName: img,
                          name: "Název",
                          location: "Lokace",
                        ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Mám chybu");
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
      floatingActionButton: Components().getHomeButton(context),
    ));
  }
}

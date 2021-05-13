import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../components/homeFloatingButton.dart';
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
        title: Text("Seznam úžasných nápadů"),
        actions: [
          IconButton(
            icon: const Icon(Icons.hardware),
            onPressed: () => Navigator.pushNamed(context, "/second"),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => Navigator.pushNamed(context, "/camera"),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: getListOfImages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: Image.file(File(snapshot.data[index])),
                          ),
                          Container(height: 10),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => removeImage(index),
                          ),
                          Container(height: 20),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Mám chybu");
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
      floatingActionButton: getHomeButton(context),
    ),
    );
  }
}

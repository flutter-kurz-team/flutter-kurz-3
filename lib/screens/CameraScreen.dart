import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

import '../components/components.dart';


class CameraScreen extends StatefulWidget {
  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  List<CameraDescription> cameras;
  SharedPreferences _prefs;
  bool started = false;

  void initState() {
    super.initState();
    initCamera();
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      started = true;
    });
  }

  void initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _saveLocation(String location) async {
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }
    List<String> savedData = _prefs.getStringList("IMAGES_PATHS") ?? [];

    savedData.add(location);
    _prefs.setStringList("IMAGES_PATHS", savedData);
    _prefs = await SharedPreferences.getInstance();
  }

  void saveImage() async {
    try {
      final image = await controller.takePicture();
      print(image.path);
      final directory = await getApplicationDocumentsDirectory();
      print(directory.path);
      String path = directory.path;

      Random random = new Random();
      int randomNumber = random.nextInt(100000000); //0 - 99999999
      String randomFileName = 'image_' + randomNumber.toString() + '.jpg';
      String newPath = '$path/$randomFileName';
      await File(image.path).rename(newPath);
      _saveLocation(newPath);
      print("Uloženo");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop: () async => false,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Kamera"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () => Navigator.pushNamed(context, "/image"),
          ),
        ],
      ),
      drawer: Components().getDrawer(context),
      drawerScrimColor: Colors.green,
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  child: CameraPreview(controller),
                  width: 200,
                  height: 200,
                ),
                ElevatedButton(child: Text("Uložit"), onPressed: saveImage),
              ],
            ),
          ],
        ),
      ),
        )
    );
  }
}

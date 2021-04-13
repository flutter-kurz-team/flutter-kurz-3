import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  List<CameraDescription> cameras;

  void initState() {
    super.initState();
    initCamera();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kamera"),
        actions: [
          IconButton(
            icon: const Icon(Icons.error),
            onPressed: () => Navigator.pushNamed(context, "/"),
          ),
        ],
      ),
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
                ElevatedButton(child: Text("Uložit"), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawer extends StatefulWidget {
  Drawer({Key key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  TextEditingController _controller;
  SharedPreferences _prefs;
  bool started = false;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      started = true;
      print("Nastartováno");
    });
  }

  void _saveText() async {
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }
    List<String> savedData = _prefs.getStringList("UZASNE_NAPADY") ?? [];

    savedData.add(_controller.text);
    _prefs.setStringList("UZASNE_NAPADY", savedData);
    _controller.clear();
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text('/')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('SecondScreen'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('CameraScreen'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('ImageScreen'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/components.dart';


class SecondScreen extends StatefulWidget {
  SecondScreen({Key key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
    return new WillPopScope(onWillPop: () async => false,
      child: Scaffold(
      appBar: AppBar(
        title: Text("Zápisník"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => Navigator.pushNamed(context, "/"),
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
                TextField(
                  controller: _controller,
                ),
                ElevatedButton(child: Text("Uložit"), onPressed: _saveText),
              ],
            ),
          ],
        ),
      ),

    )
    );
  }
}

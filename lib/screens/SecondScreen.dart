import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}


class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _controller;
  String _savedText = "";
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        _savedText = prefs.getString("textFromSecondScreen") ?? "";
      });
    });
  }

  void _saveText() async {
    await prefs.setString("textFromSecondScreen", _controller.text);
    _controller.clear();
  }

  void _reload() async {
    setState(() {
      _savedText = prefs.getString("textFromSecondScreen") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondScreen"),
      ),
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
              Column(
                children: [
                  Text("Naposledy jste napsal:"),
                  Text(_savedText),
                  ElevatedButton(
                    child: Text("Načíst"),
                    onPressed: _reload,
                  ),
                  ElevatedButton(
                    child: Text("Zpět na hlavní obrazovku"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/");
                    },
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
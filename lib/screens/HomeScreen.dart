import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _saveCounter(int counterValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("counter", counterValue);
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counterValueFromPrefs = prefs.getInt("counter") ?? 0;
    setState(() {
      _counter = counterValueFromPrefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seznam úžasných nápadů"),
      ),
      body: Center(
        child: Container(

        ),
      ),
    );
  }
}

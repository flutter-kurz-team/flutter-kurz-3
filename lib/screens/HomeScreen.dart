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
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text("Druhá obrazovka")),
            ElevatedButton(
              child: Text("Uložit"),
              onPressed: () {
                _saveCounter(_counter);
              },
            ),
            ElevatedButton(
                child: Text("Načíst"),
                onPressed: () {
                  _loadCounter();
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

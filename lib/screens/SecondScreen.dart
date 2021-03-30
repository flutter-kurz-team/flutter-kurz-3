import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondScreen"),
      ),
      body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Druhá obrazovka"),
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
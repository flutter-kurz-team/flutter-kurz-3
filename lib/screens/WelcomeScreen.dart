import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seznam úžasných nápadů'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox (
                  height: 40,
                  width: 300,
                  child: ElevatedButton.icon(onPressed: () => Navigator.pushNamed(context, '/second'),
                    icon: Icon(Icons.edit),
                    label: Text("Přidání úžasného nápadu",
                      style: TextStyle(fontSize:17.5),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox (
                  height: 40,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    icon: Icon(Icons.notes),
                    label: Text("Seznam úžasných nápadů",
                      style: TextStyle(fontSize:17.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox (
                  height: 40,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/camera'),
                    icon: Icon(Icons.camera_alt),
                    label: Text("Vyfocení úžasného nápadu",
                      style: TextStyle(fontSize:17.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox (
                  height: 40,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/image'),
                    icon: Icon(Icons.image),
                    label: Text("Galerie úžasných nápadů",
                      style: TextStyle(fontSize:17.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox (
                  height: 40,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/news'),
                    icon: Icon(Icons.mail_outline_sharp),
                    label: Text("Novinky",
                      style: TextStyle(fontSize:17.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

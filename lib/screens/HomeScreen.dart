import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<List> getListOfIdeas() async {
    if(!started) {
      _prefs = await SharedPreferences.getInstance();
    }

    return _prefs.getStringList("UZASNE_NAPADY") ?? ["Žádné položky"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seznam úžasných nápadů"),
        actions: [
          IconButton(
            icon: const Icon(Icons.hardware),
            onPressed: () => Navigator.pushNamed(context, "/second"),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: getListOfIdeas(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(child: Text(snapshot.data[index]));
                    }
                );
              }
              else if(snapshot.hasError) {
                return Text("Mám chybu");
              } else {
                return CircularProgressIndicator();
              }
            }
        ),
      ),
    );
  }
}

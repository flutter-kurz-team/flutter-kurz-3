import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/components.dart';



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
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }

    return _prefs.getStringList("UZASNE_NAPADY") ?? ["Žádné položky"];
  }

  void _remove(int index) async {
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }
    List<String> ideas = _prefs.getStringList("UZASNE_NAPADY");

    ideas.removeAt(index);

    _prefs.setStringList("UZASNE_NAPADY", ideas);
    _prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  void _clone(int index) async {
    if (!started) {
      _prefs = await SharedPreferences.getInstance();
    }
    List<String> ideas = _prefs.getStringList("UZASNE_NAPADY");
    String clone;

    clone = ideas.elementAt(index);
    ideas.add(clone);
    _prefs.setStringList("UZASNE_NAPADY", ideas);
    _prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Můj seznam"),
               actions: [
          IconButton(
            icon: const Icon(Icons.hardware),
            onPressed: () => Navigator.pushNamed(context, "/second"),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => Navigator.pushNamed(context, "/camera"),
          ),
        ],
      ),
      drawer: Components().getDrawer(context),
      body: Center(
        child: FutureBuilder(
            future: getListOfIdeas(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text(snapshot.data[index]),
                          Container(
                            color: (Colors.green),
                            child: Text(
                              snapshot.data[index],
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => _remove(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _clone(index),
                          ),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Mám chybu");
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
      floatingActionButton: Components().getHomeButton(context),
    );
  }
}

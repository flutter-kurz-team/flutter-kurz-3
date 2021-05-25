import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../components/components.dart';



class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  SharedPreferences _prefs;
  bool started = false;
  String feedUrl = "https://servis.idnes.cz/rss.aspx?c=zpravodaj";

  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      started = true;
      print("Nastartováno");
    });
  }

  Future getFeed() async {
    var url = Uri.parse(feedUrl);
    var response = await http.get(url);
    var rssFeed = RssFeed.parse(response.body);
    return rssFeed;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Novinky"),
          automaticallyImplyLeading: false,
          actions: [
          ],
        ),
        drawer: Components().getDrawer(context),
        drawerScrimColor: Colors.green,

        body: FutureBuilder(
            future: getFeed(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red)),

                    Container(
                      height: 500,
                      child:
                      ListView.builder(
                          itemCount: snapshot.data.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            var curItem = snapshot.data.items[index];
                            return Column(
                              children: [
                                Text(curItem.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(curItem.description),
                                InkWell(
                                    child: Text("Více",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,)),
                                    onTap: () async {
                                      if (await canLaunch(curItem.link)) {
                                        await launch(curItem.link);
                                      }
                                    }
                                ),
                                Container(height: 10),
                              ],
                            );
                          }
                      ),
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            }
        ),

        floatingActionButton: Components().getHomeButton(context),

      ),
    );
  }
}

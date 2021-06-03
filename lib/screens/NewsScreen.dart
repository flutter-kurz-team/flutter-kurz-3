import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/domain/media/description.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;



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
          //automaticallyImplyLeading: false,
          actions: [
          ],
        ),
        drawer: Components().getDrawer(context),
        drawerScrimColor: Colors.green,
        body: FutureBuilder(
            future: getFeed(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //snapshot.data == rssFeed
                return Column(
                  children: [
                    Text(snapshot.data.title,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                offset: Offset(4,1)
                            )
                          ]
                          ),
                      textAlign: TextAlign.center,
                    ),


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
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.combine([
                                    TextDecoration.overline
                                  ]),
                                  decorationThickness: 1.0,
                                  decorationColor: Colors.green,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2.0,
                                      offset: Offset(4,1)
                                    )
                                  ]
                                ),
                                  textAlign: TextAlign.justify,
                                ),
                                //Titulek novinek
                                Text(curItem.description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,

                                ),),

                                Container(
                                  height: 25,
                                  width: 380,
                                  color: Colors.black,

                                  ),

                                
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




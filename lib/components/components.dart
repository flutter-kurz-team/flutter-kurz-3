import 'package:flutter/material.dart';

class Components {
  Drawer getDrawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text('Zápisník'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, "/second");
            },
          ),
          ListTile(
            title: Text('Kamera'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, "/camera");
            },
          ),
          ListTile(
            title: Text('Fotky'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushNamed(context, "/image");
            },
          ),
        ],
      ),
    );
  }

  FloatingActionButton getHomeButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, "/"),
      tooltip: '/',
      child: const Icon(Icons.home),
    );
  }

}
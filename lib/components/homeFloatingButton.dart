import 'package:flutter/material.dart';

FloatingActionButton getHomeButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => Navigator.pushNamed(context, "/"),
    tooltip: '/',
    child: const Icon(Icons.home),
  );
}
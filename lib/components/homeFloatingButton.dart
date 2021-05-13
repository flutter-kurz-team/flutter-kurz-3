import 'package:flutter/material.dart';

FloatingActionButton getHomeButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => Navigator.pushNamed(context, "/welcome"),
    tooltip: '/welcome',
    child: const Icon(Icons.home),
  );
}
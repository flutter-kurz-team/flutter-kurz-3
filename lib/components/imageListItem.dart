import 'package:flutter/material.dart';
import 'dart:io';

/*
*
return Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: Image.file(File(snapshot.data[index])),
                          ),
                          Container(height: 10),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => removeImage(index),
                          ),
                          Container(height: 20),
                        ],
                      );
*
* */
@immutable
class ImageListItem extends StatelessWidget {
  const ImageListItem({
    Key key,
    this.fileName,
    this.name,
    this.location,
  }) : super(key: key);

  final String fileName;
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Image.file(
      File(fileName),
      fit: BoxFit.cover,);
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
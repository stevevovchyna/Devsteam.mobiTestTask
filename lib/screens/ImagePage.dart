import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:testapp/screens/ListPage.dart';

class ImagePage extends StatelessWidget {
  final ImageModel imageData;
  ImagePage({Key key, @required this.imageData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(imageData.author),
      ),
      body: Stack(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageData.imageURL,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:testapp/screens/ImagePage.dart';
import 'package:testapp/services/networkRequest.dart';

class ImageModel {
  final String author;
  final String imageURL;

  ImageModel(this.author, this.imageURL);
}

class ListTileModel extends StatelessWidget {
  ListTileModel({this.username, this.imageLink, this.description, this.thumbnailLink, this.altDescription});

  final String username;
  final String imageLink;
  final String description;
  final String altDescription;
  final String thumbnailLink;

  @override
  Widget build(BuildContext context) {
    return Card(
        child:
        ListTile(
          leading:
          CircleAvatar(
            backgroundImage: NetworkImage(thumbnailLink != null ? thumbnailLink : imageLink),
          ),
          title: Text(description == null ? altDescription : description),
          subtitle: Text(username),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePage(imageData: ImageModel(username, imageLink))),
            );
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
        ));
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<ImageDataModel>> requestResult;
  final String clientID = "cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0";
  @override
  void initState() {
    super.initState();
    requestResult = NetworkHelper(clientID).fetchAlbum();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<ImageDataModel>>(
          future: requestResult,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ListTileModel> imagesArray = [];
              for (var item in snapshot.data) {
                imagesArray.add(ListTileModel(username: item.username,
                  imageLink: item.imageLink,
                  description: item.description, altDescription: item.altDescription, thumbnailLink: item.thumbnailLink,));
              }
              return Container(
                color: Colors.white,
                child: ListView(
                  children: imagesArray,
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
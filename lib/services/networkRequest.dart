import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ImageDataModel {
  final String username;
  final String imageLink;
  final String description;
  final String thumbnailLink;
  final String altDescription;

  ImageDataModel({this.username, this.imageLink, this.description, this.thumbnailLink, this.altDescription});

  factory ImageDataModel.fromJson(Map<String, dynamic> json) {
    return ImageDataModel(
        username: json['user']['username'],
        imageLink: json['urls']['regular'],
        description: json['description'],
        altDescription: json['alt_description'],
        thumbnailLink: json['urls']['thumb']
    );
  }
}

class NetworkHelper {
  NetworkHelper(this.clientID);

  final String clientID;

  Future<List<ImageDataModel>> fetchAlbum() async {
    final response = await http.get("https://api.unsplash.com/photos/?client_id=" + clientID);

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((i) => ImageDataModel.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}

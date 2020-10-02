import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:irmaos_de_sangue/pages/_models/video.dart';

const API_KEY = "AIzaSyCBxUY1mwR-OTUWSEPU-23BKU5cqPKhW6I";

class Api {
  String _search;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=4");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}

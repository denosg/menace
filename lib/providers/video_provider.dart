
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class VideoProvider with ChangeNotifier {
  Future<void> getVideosFromPH() async {
    Uri url = Uri.parse('https://www.pornhub.com/');
    try {
      final response = await http.get(url);
      var htmlDocument = parser.parse(response.body);
      final mp4Urls =
          htmlDocument.querySelectorAll('video.js-gifVideoBlock source.js-mp4');
      for (final mp4Url in mp4Urls) {
        final url = mp4Url.attributes['src'];
        print(url); // prints the URL of the .mp4 file
      }
    } catch (e) {
      print(e);
    }
  }
}

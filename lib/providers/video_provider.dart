import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class VideoProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<String> _videoList = [];

  List<String> get videos {
    return [..._videoList];
  }

  Future<void> getVideosFromPH() async {
    Uri url = Uri.parse('https://www.pornhub.com/');
    try {
      final response = await http.get(url);
      var htmlDocument = parser.parse(response.body);
      final mp4Urls = htmlDocument.querySelectorAll('video');
      for (final mp4Url in mp4Urls) {
        final url = mp4Url.attributes['data-mp4'];
        if (url != null) {
          _videoList.add(url);
          print(url);
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}

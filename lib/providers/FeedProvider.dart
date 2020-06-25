import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeedProvider with ChangeNotifier {
  final String _urlVideos = '${Constants.BASE_API_URL}/videos';

  List<Video> _videoList = [];

  List<Video> get videoList => _videoList;

  Future<void> loadFeed(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final res = await http
        .get('$_urlVideos/feed/$id', headers: {'Authorization': token});

    List<Video> videoList = [];
    if (res.statusCode == 200) {
      List body = json.decode(res.body);
      for (var video in body) {
        videoList.add(Video.fromJson(video));
      }
      _videoList = videoList;
      notifyListeners();
    }
  }

  resetFeed() {
    _videoList = [];
    notifyListeners();
  }
}

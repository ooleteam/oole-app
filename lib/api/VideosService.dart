import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VideoService with ChangeNotifier {
  final String url = '${Constants.BASE_API_URL}/videos';

  Future<List<Video>> videosByJogador(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final res = await http.get('$url/by-player/$id', headers: {'Authorization': token});

    List<Video> _videoList = [];
    if (res.statusCode == 200) {
      List body = json.decode(res.body);
      for (var video in body) {
        _videoList.add(Video.fromJson(video));
      }
      // _videoList = Video.fromJson(json.decode(res.body));
      notifyListeners();
      return _videoList;
    }
  }
}
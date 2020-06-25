import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VideoProvider with ChangeNotifier {
  final String _urlVideos = '${Constants.BASE_API_URL}/videos';

  Video _video;
  bool _isStarred;

  get video => _video;
  bool get isStarred => _isStarred;

  Future<void> loadVideo(Video video) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    int id = prefs.getInt('userID');

    final res = await http
        .get('$_urlVideos/${video.id}', headers: {'Authorization': token});

    _video = Video.fromJson(json.decode(res.body));
    _isStarred = false;
    _video.like.forEach((element) {
      if (element.id == id) {
        _isStarred = true;
      }
    });

    notifyListeners();
  }

  Future<String> createVideo(
      File file, String title, String desc, int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    var req = http.MultipartRequest('POST', Uri.parse(_urlVideos));
    req.files.add(await http.MultipartFile.fromPath('file', file.path));
    req.fields['title'] = title;
    req.fields['desc'] = desc;
    req.fields['id'] = '$id';
    req.headers.addAll({"Authorization": token});

    var res = await req.send();
    return res.statusCode.toString();
  }

  Future<void> star(user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    int id = prefs.getInt('userID');
    print(_video.id);

    _isStarred = !_isStarred;
    final res = await http.put(
        '$_urlVideos/like?idUser=$id&idVideo=${_video.id}',
        headers: {'Authorization': token});

    loadVideo(_video);
  }

  resetVideo() {
    _video = null;
    _isStarred = false;

    notifyListeners();
  }
}

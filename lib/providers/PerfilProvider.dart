import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Olheiro.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PerfilProvider with ChangeNotifier {
  final String _urlJogadores = '${Constants.BASE_API_URL}/jogadores';
  final String _urlOlheiros = '${Constants.BASE_API_URL}/olheiros';
  final String _urlVideos = '${Constants.BASE_API_URL}/videos';

  var _owner;
  String _ownerType = '';
  List<Video> _perfilVideos = [];

  String get ownerType => _ownerType;

  get owner => _owner;
  int get totalSeguidores => _owner.seguidores.length;
  int get totalObservadores => _owner.observadores.length;
  int get totalSeguindo => _owner.seguindo.length;
  List<Video> get perfilVideos => _perfilVideos;

  Future<void> loadPerfil(int id, String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    // String userType = prefs.getString("userType");
    // int id = prefs.getInt('userID');
    _ownerType = type;
    if (type == 'Jogador') {
      final res = await http
          .get('$_urlJogadores/$id', headers: {'Authorization': token});

      _owner = Jogador();
      if (res.statusCode == 200) {
        _owner = Jogador.fromJson(json.decode(res.body));
        notifyListeners();
      }

      final resVideos = await http
          .get('$_urlVideos/by-player/$id', headers: {'Authorization': token});

      _perfilVideos = [];
      if (resVideos.statusCode == 200) {
        List body = json.decode(resVideos.body);
        for (var video in body) {
          _perfilVideos.add(Video.fromJson(video));
        }
        notifyListeners();
      }
    } else if (type == 'Olheiro') {
      final resUser = await http
          .get('$_urlOlheiros/$id', headers: {'Authorization': token});

      _owner = Olheiro();
      if (resUser.statusCode == 200) {
        _owner = Olheiro.fromJson(json.decode(resUser.body));
        notifyListeners();
      }

      print(_owner.nome + "  " + _ownerType);

      notifyListeners();
    }
  }

  resetPerfil() {
    _owner = null;
    _ownerType = '';
    _perfilVideos = [];
    notifyListeners();
  }
}

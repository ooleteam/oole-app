import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Olheiro.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UserProvider with ChangeNotifier {
  final String _urlJogadores = '${Constants.BASE_API_URL}/jogadores';
  final String _urlOlheiros = '${Constants.BASE_API_URL}/olheiros';
  final String _urlVideos = '${Constants.BASE_API_URL}/videos';

  var _user;
  String _userType = '';
  List<Video> _perfilVideos = [];
  Map<String, Object> _cartao = {};
  bool _hasCartao = false;

  get user => _user;
  String get userType => _userType;
  List<Video> get perfilVideos => _perfilVideos;
  Map<String, Object> get cartao => _cartao;
  bool get hasCartao => _hasCartao;

  String createCartao(Map<String, Object> cartao) {
    _cartao = cartao;
    _hasCartao = true;
    notifyListeners();
    return cartao['nomeDoTitular'];
  }

  Future follow(int seguidoId) async {
    print(_user.id.toString() + ' => ' + seguidoId.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (userType == "Jogador") {
      await http.put(
          '$_urlJogadores/follow?userid=${_user.id}&seguidoid=$seguidoId',
          headers: {
            'Authorization': token,
          }).then((value) => print(value.statusCode));

      await loadUser();
      notifyListeners();
    } else if (userType == "Olheiro") {
      await http.put(
          '$_urlOlheiros/follow?userid=${_user.id}&seguidoid=$seguidoId',
          headers: {
            'Authorization': token,
          }).then((value) => print(value.statusCode));

      await loadUser();
      notifyListeners();
    }
  }

  Future observar(int seguidoId) async {
    print(_user.id.toString() + ' => ' + seguidoId.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final res = await http.put(
        '$_urlOlheiros/observar?userid=${_user.id}&seguidoid=$seguidoId',
        headers: {
          'Authorization': token,
        });

    print(res.statusCode);
    await loadUser();
    notifyListeners();
  }

  Future desobservar(int seguidoId) async {
    print(_user.id.toString() + ' => ' + seguidoId.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (userType == "Jogador") {
      await http.put(
          '$_urlJogadores/desobservar?userid=${_user.id}&seguidoid=$seguidoId',
          headers: {
            'Authorization': token,
          }).then((value) => print(value.statusCode));

      await loadUser();
      notifyListeners();
    } else if (userType == "Olheiro") {
      await http.put(
          '$_urlOlheiros/unfollow?userid=${_user.id}&seguidoid=$seguidoId',
          headers: {
            'Authorization': token,
          }).then((value) => print(value.statusCode));

      await loadUser();
      notifyListeners();
    }
  }

  Future unfollow(int seguidoId) async {
    print(_user.id.toString() + ' =>X ' + seguidoId.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    if (userType == "Jogador") {
      await http.put(
          '$_urlJogadores/unfollow?userid=${_user.id}&seguidoid=$seguidoId',
          headers: {
            'Authorization': token,
          }).then((value) => print(value.statusCode));

      await loadUser();
      notifyListeners();
    } else if (userType == "Olheiro") {
      await http.put(
          '$_urlOlheiros/unfollow?userid=${_user.id}&seguidoid=$seguidoId',
          headers: {
            'Authorization': token,
          }).then((value) => print(value.statusCode));

      await loadUser();
      notifyListeners();
    }
  }

  Future updateUser(File file, user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (userType == "Jogador") {
      var stream = new http.ByteStream(file.openRead());
      var length = await file.length();
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      }; //
      var uri = Uri.parse(_urlJogadores + "/jogadores/${user.id}/fotoperfil");

      var request = new http.MultipartRequest("PUT", uri);

      var multipartFileSign = new http.MultipartFile('file', stream, length,
          filename: basename(file.path));
      request.files.add(multipartFileSign);
      request.headers.addAll(headers);
      var response = await request.send();
      print(response.statusCode);

      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      if (response.statusCode == 201) {
        loadUser();
      }
    }
  }

  Future loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    _userType = prefs.getString("userType");
    int id = prefs.getInt('userID');
    print(_userType);
    if (_userType == 'Jogador') {
      final resUser = await http
          .get('$_urlJogadores/$id', headers: {'Authorization': token});

      _user = Jogador();
      if (resUser.statusCode == 200) {
        _user = Jogador.fromJson(json.decode(resUser.body));
        notifyListeners();
      }

      print(_user.nome);

      final resVideos = await http
          .get('$_urlVideos/by-player/$id', headers: {'Authorization': token});

      if (resVideos.statusCode == 200) {
        List body = json.decode(resVideos.body);
        for (var video in body) {
          _perfilVideos.add(Video.fromJson(video));
        }

        notifyListeners();
      }
    } else if (_userType == 'Olheiro') {
      final resUser = await http
          .get('$_urlOlheiros/$id', headers: {'Authorization': token});

      _user = Olheiro();
      if (resUser.statusCode == 200) {
        _user = Olheiro.fromJson(json.decode(resUser.body));
        notifyListeners();
      }

      notifyListeners();
    }
  }

  resetUser() {
    _user = null;
    _userType = '';
    _perfilVideos = [];
    notifyListeners();
  }
}

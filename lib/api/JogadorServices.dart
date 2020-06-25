import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JogadorService with ChangeNotifier {
  final String url = '${Constants.BASE_API_URL}/jogadores';
  Jogador _user;
  Jogador _perfilOwnerUser;
  bool _isFollowing;
  List<Jogador> _searchList = [];

  Jogador get user => _user;
  Jogador get perfilOwnerUser => _perfilOwnerUser;
  bool get isFollowing => _isFollowing;
  List<Jogador> get searchList => _searchList;

  Future<void> follow(int seguidoId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    int id = prefs.getInt('userID');

    await http.put('$url/follow?userid=$id&seguidoid=$seguidoId', headers: {
      'Authorization': token,
    }).then((value) => print(value.statusCode));

    _isFollowing = true;
    await loadCurrentUser();
    await loadPerfilOwnerUser(id);
    notifyListeners();
  }

  Future<void> unfollow(int seguidoId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    int id = prefs.getInt('userID');

    await http.put('$url/unfollow?userid=$id&seguidoid=$seguidoId', headers: {
      'Authorization': token,
    }).then((value) => print(value.statusCode));

    _isFollowing = false;
    await loadCurrentUser();
    await loadPerfilOwnerUser(id);
    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    _user = Jogador();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userID');
    String token = prefs.getString("token");

    final res = await http.get('$url/$id', headers: {'Authorization': token});

    if (res.statusCode == 200) {
      _user = Jogador.fromJson(json.decode(res.body));
      notifyListeners();
    }

    searchJogadores('');
  }

  Future<void> searchJogadores(String login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final res = await http.get('$url/search?login=$login', headers: {
      'Authorization': token,
    });

    final body = json.decode(res.body);

    if (res.statusCode == 200) {
      List<Jogador> aux = [];
      for (var jogador in body['content']) {
        // print(Jogador.fromJson(jogador).nome);
        aux.add(Jogador.fromJson(jogador));
      }
      _searchList = aux;
      notifyListeners();
    }
  }

  Future<void> loadPerfilOwnerUser(int id) async {
    // _perfilOwnerUser = Jogador();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final res = await http.get('$url/$id', headers: {'Authorization': token});

    _perfilOwnerUser = Jogador();

    if (res.statusCode == 200) {
      _perfilOwnerUser = Jogador.fromJson(json.decode(res.body));
      if (user.seguindo != null) {
        user.seguindo.forEach((element) {
          if (element.id == _perfilOwnerUser.id) {
            _isFollowing = true;

            notifyListeners();
          }
        });
      } else {
        _isFollowing = false;
        notifyListeners();
      }
    }
  }
}

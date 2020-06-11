import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JogadorService with ChangeNotifier {
  final String url = '${Constants.BASE_API_URL}/jogadores';
  Jogador _user;

  List<Jogador> _searchList = [];

  Jogador get user => _user;

  List<Jogador> get searchList => _searchList;

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

  Future<Jogador> searchJogadorById(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final res = await http.get('$url/$id', headers: {'Authorization': token});

    Jogador jogador = Jogador();

    if (res.statusCode == 200) {
      jogador = Jogador.fromJson(json.decode(res.body));
      notifyListeners();
      return jogador;
    }

    return null;
  }
}

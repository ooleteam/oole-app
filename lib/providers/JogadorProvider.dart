import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class JogadorProvider with ChangeNotifier {
  final String _urlJogadores = '${Constants.BASE_API_URL}/jogadores';
  final String _urlOlheiros = '${Constants.BASE_API_URL}/olheiros';
  final String _urlVideos = '${Constants.BASE_API_URL}/videos';

  List<Jogador> _jogadores = [];
  List<Jogador> get jogadores => _jogadores;

  Future<void> searchJogadores(String login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    print(login);
    final res = await http.get('$_urlJogadores/search?login=$login', headers: {
      'Authorization': token,
    });

    final body = json.decode(res.body);
    if (res.statusCode == 200) {
      _jogadores = [];
      for (var jogador in body['content']) {
        _jogadores.add(Jogador.fromJson(jogador));
      }
      notifyListeners();
    }
  }
}

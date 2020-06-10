import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JogadorService with ChangeNotifier{
  final String url = '${Constants.BASE_API_URL}/jogadores';
  Jogador _user;

  Jogador get user => _user;

  Future<void> loadCurrentUser() async{
    _user = Jogador();
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('userID');
    String token = prefs.getString("token");

    final res = await http.get('$url/$id', headers: {
      'Authorization': token
    });

    if(res.statusCode == 200){
      _user = Jogador.fromJson(json.decode(res.body));
      notifyListeners();
    }
  }
}
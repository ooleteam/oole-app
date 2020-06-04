import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/api/OlheiroService.dart';
import 'package:oole_app/models/Credential.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final String url = '${Constants.BASE_API_URL}/login';
  final JogadorService jogadorService = JogadorService();
  final OlheiroService olheiroService = OlheiroService();

  Future<int> logIn(Credential credencial) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final res = await http.post(
      url,
      body: json.encode({
        'email': credencial.email,
        'senha': credencial.senha
      }),
    );

    if(res.statusCode == 200){
      var body = json.decode(res.body);
      await prefs.setInt("userID",body["id"]);
      await prefs.setString("userType",body["tipo"]);
      await prefs.setString("token", res.headers['authorization']);
    }

    return res.statusCode;
  }

  logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userID");
    await prefs.remove("userType");
    await prefs.remove("token");
  }
}

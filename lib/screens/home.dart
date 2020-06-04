import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  String _tipo;
  var _user;

  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  _loadApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _tipo = prefs.getString("userType");

    if (_tipo == "Jogador") {
      await Provider.of<JogadorService>(context, listen: false)
          .loadCurrentUser();
      setState(() {
        _user = Provider.of<JogadorService>(context, listen: false).user;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: Text(_user.nome),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Jogador user = Provider.of<JogadorService>(context).user;
    return user == null
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Text(user.nome),
          );
  }
}

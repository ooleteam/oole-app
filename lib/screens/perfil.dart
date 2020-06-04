import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/components/AppBar.dart';
import 'package:oole_app/components/Perfil/PerfilBody.dart';
import 'package:oole_app/components/PerfilHeader.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:provider/provider.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Jogador user = Provider.of<JogadorService>(context).user;
    return Scaffold(
      appBar: CustomBar(user.login),
      drawer: Drawer(
        child: Text('Menu'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PerfilHeader(user),
            PerfilBody(user.videos),
          ],
        ),
      ),
    );
  }
}

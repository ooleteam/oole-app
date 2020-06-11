import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/components/Perfil/PerfilBody.dart';
import 'package:oole_app/components/Perfil/PerfilHeader.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:provider/provider.dart';

class Perfil extends StatelessWidget {
  final Jogador user;

  Perfil({this.user});

  @override
  Widget build(BuildContext context) {
    final Jogador user =  
        this.user != null ?  this.user : Provider.of<JogadorService>(context).user;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PerfilHeader(user),
          SizedBox(
            width: double.infinity,
            height: 1,
            child: Container(
              color: Colors.green[400],
            ),
          ),
          PerfilBody(user.videos),
        ],
      ),
    );
  }
}

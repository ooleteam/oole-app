import 'package:flutter/material.dart';
import 'package:oole_app/components/Perfil/PerfilInfoHeader.dart';
import 'package:oole_app/components/Perfil/PerfilMainHeader.dart';

class PerfilHeader extends StatelessWidget {
  final _user;

  PerfilHeader(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PerfilMainHeader(
            _user.urlFotoPerfil,
            _user.observadores.length,
            _user.seguidores.length,
            _user.seguindo.length,
            _user.nome,
            _user.posicao,
          ),
          PerfilInfoHeader(_user),
        ],
      ),
    );
  }
}

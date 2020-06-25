import 'package:flutter/material.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';

import 'PerfilJogadorToJogador.dart';

class SeguidoresJogador extends StatelessWidget {
  final List list;

  SeguidoresJogador({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar("List de Seguidores"),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                list[index].urlFotoPerfil != null
                    ? list[index].urlFotoPerfil
                    : Constants.DEFAULT_USER_FOTO_PERFIL,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  list[index].login,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.green[400],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${Formaters.nomeFormmater(list[index].nome)} - ${list[index].posicao}",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PerfilJogadorToJogador(id: list[index].id)),
              );
            },
          );
        },
      ),
    );
  }
}

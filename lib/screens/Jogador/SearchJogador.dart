import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/providers/JogadorProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/screens/Jogador/PerfilJogadorToJogador.dart';
import 'package:oole_app/screens/Jogador/SeguidoresJogador.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class SearchJogador extends StatefulWidget {
  @override
  _SearchJogadorState createState() => _SearchJogadorState();
}

class _SearchJogadorState extends State<SearchJogador> {
  List<Jogador> _jogadores;

  @override
  void didChangeDependencies() {
    _jogadores = Provider.of<JogadorProvider>(context).jogadores;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return _jogadores.isEmpty
        ? Center(child: Text("Nenhuma busca realizada ainda"))
        : ListView.builder(
            itemCount: _jogadores.length,
            itemBuilder: (ctx, i) {
              if (_jogadores[i].id == userProvider.user.id) {
                return Container();
              }
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _jogadores[i].urlFotoPerfil != null
                        ? _jogadores[i].urlFotoPerfil
                        : Constants.DEFAULT_USER_FOTO_PERFIL,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _jogadores[i].login,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.green[400],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${Formaters.nomeFormmater(_jogadores[i].nome)} - ${_jogadores[i].posicao}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PerfilJogadorToJogador(id: _jogadores[i].id)),
                  );
                },
              );
            },
          );
  }
}

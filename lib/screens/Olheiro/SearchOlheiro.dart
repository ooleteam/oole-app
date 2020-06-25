import 'package:flutter/material.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Olheiro.dart';
import 'package:oole_app/providers/JogadorProvider.dart';
import 'package:oole_app/providers/OlheiroProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/screens/Jogador/PerfilOlheiroToJogador.dart';
import 'package:oole_app/screens/Olheiro/PerfilJogadorToOlheiro.dart';
import 'package:oole_app/screens/Olheiro/PerfilOlheiroToOlheiro.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class SearchOlheiro extends StatefulWidget {
  @override
  _SearchOlheiroState createState() => _SearchOlheiroState();
}

class _SearchOlheiroState extends State<SearchOlheiro> {
  List<Jogador> _jogadores;
  List<Olheiro> _olheiros;
  bool _olheiroOrJogador = true;

  @override
  void didChangeDependencies() {
    _jogadores = Provider.of<JogadorProvider>(context).jogadores;
    _olheiros = Provider.of<OlheiroProvider>(context).olheiros;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Procurar por:"),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: false,
                      groupValue: _olheiroOrJogador,
                      activeColor: Colors.green[400],
                      onChanged: (value) {
                        setState(() {
                          _olheiroOrJogador = value;
                        });
                      },
                    ),
                    Text("Jogadores"),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: true,
                      groupValue: _olheiroOrJogador,
                      activeColor: Colors.green[400],
                      onChanged: (value) {
                        setState(() {
                          _olheiroOrJogador = value;
                        });
                      },
                    ),
                    Text("Olheiros"),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: _olheiroOrJogador
                ? ListView.builder(
                    itemCount: _olheiros.length,
                    itemBuilder: (ctx, i) {
                      if (_olheiros[i].id ==
                          Provider.of<UserProvider>(context).user.id) {
                        return Container();
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            _olheiros[i].urlFotoPerfil != null
                                ? _olheiros[i].urlFotoPerfil
                                : Constants.DEFAULT_USER_FOTO_PERFIL,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _olheiros[i].login,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${Formaters.nomeFormmater(_olheiros[i].nome)}",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PerfilOlheiroToOlheiro(
                                    id: _olheiros[i].id)),
                          );
                        },
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: _jogadores.length,
                    itemBuilder: (ctx, i) {
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
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600]),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PerfilJogadorToOlheiro(
                                    id: _jogadores[i].id)),
                          );
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

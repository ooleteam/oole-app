import 'package:flutter/material.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/screens/Jogador/PerfilJogadorToJogador.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class PerfilOlheiroToJogador extends StatefulWidget {
  final int id;

  PerfilOlheiroToJogador({this.id});

  @override
  _PerfilOlheiroToJogadorState createState() => _PerfilOlheiroToJogadorState();
}

class _PerfilOlheiroToJogadorState extends State<PerfilOlheiroToJogador> {
  var owner;
  bool _isLoading = true;
  int _totalSeguindo;
  int _totalObservadores;
  int _totalSeguidores;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loadPerfilOwner(context);
    super.didChangeDependencies();
  }

  _loadPerfilOwner(BuildContext context) async {
    Provider.of<PerfilProvider>(context, listen: false)
        .loadPerfil(widget.id, "Olheiro")
        .then((_) {
      final provider = Provider.of<PerfilProvider>(context, listen: false);
      setState(() {
        owner = provider.owner;
        print(owner.id);
        _totalSeguindo = owner.seguindo.length;
        _totalObservadores = owner.observados.length;
        _totalSeguidores = owner.seguidores.length;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: CustomBar(owner.login),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: owner.urlFotoPerfil != null
                                          ? NetworkImage(owner.urlFotoPerfil)
                                          : NetworkImage(Constants
                                              .DEFAULT_USER_FOTO_PERFIL),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('$_totalObservadores'),
                                    Text("Observados"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('$_totalSeguidores'),
                                    Text("Seguidores"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('$_totalSeguindo'),
                                    Text("Seguindo"),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              owner.nome,
                              style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Container(height: 1, color: Colors.green[400]),
//=============================================================FIM HEADER=============================================================
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: _totalObservadores,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              owner.observados[index].urlFotoPerfil != null
                                  ? owner.observados[index].urlFotoPerfil
                                  : Constants.DEFAULT_USER_FOTO_PERFIL,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                owner.observados[index].login,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.green[400],
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${Formaters.nomeFormmater(owner.observados[index].nome)} - ${owner.observados[index].posicao}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PerfilJogadorToJogador(
                                      id: owner.observados[index].id)),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     PerfilHeader(isCurrentUser),
            //     SizedBox(
            //       width: double.infinity,
            //       height: 1,
            //       child: Container(
            //         color: Colors.green[400],
            //       ),
            //     ),
            //     FutureBuilder<List<Video>>(
            //       future: videos,
            //       builder: (ctx, snapshot) => PerfilBody(snapshot.data),
            //     ),
            //   ],
            // ),
          )
        : LoadingCircle();
  }
}

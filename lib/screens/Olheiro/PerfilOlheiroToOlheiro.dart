import 'package:flutter/material.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/screens/Jogador/PerfilJogadorToJogador.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class PerfilOlheiroToOlheiro extends StatefulWidget {
  final int id;

  PerfilOlheiroToOlheiro({this.id});

  @override
  _PerfilOlheiroToOlheiroState createState() => _PerfilOlheiroToOlheiroState();
}

class _PerfilOlheiroToOlheiroState extends State<PerfilOlheiroToOlheiro> {
  var owner;
  bool _isLoading = true;
  bool _isFollowing = false;
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
      final user = Provider.of<UserProvider>(context, listen: false).user;
      setState(() {
        owner = provider.owner;
        print(owner.id);
        _totalSeguindo = owner.seguindo.length;
        _totalObservadores = owner.observados.length;
        _totalSeguidores = owner.seguidores.length;
        for (var olheiro in user.seguindo) {
          if (widget.id == olheiro.id) {
            _isFollowing = true;
          }
        }
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

                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      !(Provider.of<UserProvider>(context).user.id == owner.id)
                          ? RaisedButton(
                              textColor: Colors.white,
                              color: _isFollowing
                                  ? Colors.red[400]
                                  : Colors.green[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                  _isFollowing ? 'Deixar de seguir' : 'Seguir'),
                              onPressed: () async {
                                if (_isFollowing) {
                                  setState(() {
                                    _isFollowing = false;
                                    _totalSeguidores -= 1;
                                  });
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .unfollow(owner.id);
                                } else {
                                  setState(() {
                                    _isFollowing = true;
                                    _totalSeguidores += 1;
                                  });
                                  await Provider.of<UserProvider>(context,
                                          listen: false)
                                      .follow(owner.id);
                                }
                              },
                            )
                          : Container(),
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

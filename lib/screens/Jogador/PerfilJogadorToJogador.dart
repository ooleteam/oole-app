import 'package:flutter/material.dart';
import 'package:oole_app/components/VideoPlayer.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:provider/provider.dart';

class PerfilJogadorToJogador extends StatefulWidget {
  final int id;

  PerfilJogadorToJogador({this.id});

  @override
  _PerfilJogadorToJogadorState createState() => _PerfilJogadorToJogadorState();
}

class _PerfilJogadorToJogadorState extends State<PerfilJogadorToJogador> {
  var owner;
  List<Video> _listVideos = [];
  bool _isFollowing;
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
        .loadPerfil(widget.id, "Jogador")
        .then((_) {
      final provider = Provider.of<PerfilProvider>(context, listen: false);
      final user = Provider.of<UserProvider>(context, listen: false).user;
      setState(() {
        owner = provider.owner;
        print(owner.nome);
        _listVideos = provider.perfilVideos;
        _isFollowing = false;
        _totalSeguindo = provider.totalSeguindo;
        _totalObservadores = provider.totalObservadores;
        _totalSeguidores = provider.totalSeguidores;
        for (var jogador in user.seguindo) {
          if (widget.id == jogador.id) {
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
            body: Container(
              child: Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      Text("Observadores"),
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
                              ),
                              Text(
                                owner.posicao,
                                style: TextStyle(
                                  color: Colors.green[400],
                                  fontWeight: FontWeight.bold,
                                ),
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
                        !(Provider.of<UserProvider>(context).user.id ==
                                owner.id)
                            ? RaisedButton(
                                textColor: Colors.white,
                                color: _isFollowing
                                    ? Colors.red[400]
                                    : Colors.green[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(_isFollowing
                                    ? 'Deixar de seguir'
                                    : 'Seguir'),
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
                        child: GridView.builder(
                          itemCount:
                              _listVideos != null ? _listVideos.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return VideoPlayerScreen(_listVideos[index]);
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 1),
                        )),
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
            ),
          )
        : LoadingCircle();
  }
}

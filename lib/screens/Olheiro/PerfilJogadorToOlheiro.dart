import 'package:flutter/material.dart';
import 'package:oole_app/components/VideoPlayer.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/providers/JogadorProvider.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class PerfilJogadorToOlheiro extends StatefulWidget {
  final int id;

  PerfilJogadorToOlheiro({this.id});

  @override
  _PerfilJogadorToOlheiroState createState() => _PerfilJogadorToOlheiroState();
}

class _PerfilJogadorToOlheiroState extends State<PerfilJogadorToOlheiro> {
  var owner;
  List<Video> _listVideos = [];
  bool _isObserving;
  String _ownerType;
  bool _expanded = false;
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
      final providerUser = Provider.of<UserProvider>(context, listen: false);
      setState(() {
        owner = provider.owner;
        print(owner.nome);
        _listVideos = provider.perfilVideos;
        _ownerType = provider.ownerType;

        _isObserving = false;
        _totalSeguindo = provider.totalSeguindo;
        _totalObservadores = provider.totalObservadores;
        _totalSeguidores = provider.totalSeguidores;
        for (var jogador in providerUser.user.observados) {
          if (widget.id == jogador.id) {
            _isObserving = true;
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
                              _ownerType == "Jogador"
                                  ? Text(
                                      owner.posicao,
                                      style: TextStyle(
                                          color: Colors.green[400],
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
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
                        RaisedButton(
                          textColor: Colors.white,
                          color: _isObserving
                              ? Colors.red[400]
                              : Colors.green[400],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child:
                              Text(_isObserving ? "Desobservar" : "Observar"),
                          onPressed: () async {
                            if (_isObserving) {
                              setState(() {
                                _isObserving = false;
                                _totalObservadores -= 1;
                              });
                              Provider.of<UserProvider>(context, listen: false)
                                  .desobservar(owner.id);
                            } else {
                              setState(() {
                                _isObserving = true;
                                _totalObservadores += 1;
                              });
                              await Provider.of<UserProvider>(context,
                                      listen: false)
                                  .observar(owner.id);
                            }
                          },
                        ),
                        Provider.of<UserProvider>(context).hasCartao
                            ? RaisedButton(
                                color: Colors.grey[200],
                                shape: BeveledRectangleBorder(),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Informações'),
                                    Icon(_expanded
                                        ? Icons.expand_less
                                        : Icons.expand_more),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _expanded = !_expanded;
                                  });
                                },
                              )
                            : Container(),
                        _expanded
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.grey[100],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Data de Nascimento: ' +
                                          owner.dataNascimento,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Sexo: ' + owner.sexo,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Estado de saúde: ' +
                                          ((owner.problemaSaude == '' ||
                                                  owner.problemaSaude == null)
                                              ? "Saúdavel"
                                              : owner.problemaSaude),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Email: ' + owner.email,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Telefone: ' +
                                          Formaters.telefoneFormmater(
                                              owner.telefone),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Endereço: ${owner.endereco}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Bairro: ${owner.bairro} ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Cidade: ${owner.cidade} / ${owner.estado}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Container(height: 1, color: Colors.green[400]),
//=============================================================FIM HEADER=============================================================
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: _listVideos != null ? _listVideos.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          return VideoPlayerScreen(_listVideos[index]);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1),
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
            ),
          )
        : LoadingCircle();
  }
}

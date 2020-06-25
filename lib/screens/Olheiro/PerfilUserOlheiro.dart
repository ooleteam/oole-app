import 'package:flutter/material.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/screens/Olheiro/PerfilJogadorToOlheiro.dart';
import 'package:oole_app/screens/Olheiro/SeguidoresOlheiros.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class PerfilUserOlheiro extends StatefulWidget {
  final int id;

  PerfilUserOlheiro({this.id});

  @override
  _PerfilUserOlheiroState createState() => _PerfilUserOlheiroState();
}

class _PerfilUserOlheiroState extends State<PerfilUserOlheiro> {
  var owner;
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
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var user = userProvider.user;
    Provider.of<PerfilProvider>(context, listen: false)
        .loadPerfil(user.id, "Olheiro")
        .then((_) {
      setState(() {
        final provider = Provider.of<PerfilProvider>(context, listen: false);
        owner = provider.owner;
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
        ? Container(
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
                                InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      Text('$_totalSeguidores'),
                                      Text("Seguidores"),
                                    ],
                                  ),
                                  onTap: () {
                                    List list = owner.seguidores;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SeguidoresOlheiro(list: list)),
                                    );
                                  },
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
                        color: Colors.grey[200],
                        shape: BeveledRectangleBorder(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ),
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
                                "${Formaters.nomeFormmater(owner.observados[index].nome)}",
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

import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void _handlerNavigation(int id) {
    Navigator.of(context).pushNamed(
      AppRoutes.PERFIL,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Jogador> _searchList = Provider.of<JogadorService>(context).searchList;
    return _searchList.isEmpty
        ? Center(child: Text("Nenhuma busca realizada ainda"))
        : ListView.builder(
            itemCount: _searchList.length,
            itemBuilder: (ctx, i) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _searchList[i].urlFotoPerfil != null
                        ? _searchList[i].urlFotoPerfil
                        : Constants.DEFAULT_USER_FOTO_PERFIL,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _searchList[i].login,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.green[400],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${Formaters.nomeFormmater(_searchList[i].nome)} - ${_searchList[i].posicao}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    )
                  ],
                ),
                onTap: () {
                  _handlerNavigation(_searchList[i].id);
                },
              );
            },
          );
  }
}

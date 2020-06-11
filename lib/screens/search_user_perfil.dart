import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/screens/perfil.dart';
import 'package:provider/provider.dart';

class SearchUserPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments;
    Future<Jogador> res = Provider.of<JogadorService>(context, listen: false).searchJogadorById(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
      ),
      body: FutureBuilder<Jogador>(
        future: res,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Perfil(user: snapshot.data,);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

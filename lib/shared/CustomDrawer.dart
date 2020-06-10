import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Jogador user = Provider.of<JogadorService>(context).user;
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration( 
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.dstATop),
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1508098682722-e99c43a406b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.urlFotoPerfil),
                ),
                title: user.sexo == "Feminino"
                    ? Text("Bem Vinda,\n${user.nome}")
                    : Text("Bem Vindo,\n${user.nome}"),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar Perfil'),
              onTap: () {
                print("Tela de edição");
                // Navigator.of(context).pushNamed(
                //   AppRoutes.EDITAR_PERFIL
                // );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Videos Mais curtidos'),
              onTap: () {
                print("Tela de destaques");
                // Navigator.of(context).pushNamed(
                //   AppRoutes.EDITAR_PERFIL
                // );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text('Lista de observadores'),
              onTap: () {
                print("Tela de observadores");
                // Navigator.of(context).pushNamed(
                //   AppRoutes.EDITAR_PERFIL
                // );
              },
            ),
            Divider(),
            Expanded(child: SizedBox()),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                print("Logout");
                // Navigator.of(context).pushNamed(
                //   AppRoutes.EDITAR_PERFIL
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}

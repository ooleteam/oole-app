import 'package:flutter/material.dart';
import 'package:oole_app/api/LoginService.dart';
import 'package:oole_app/providers/FeedProvider.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/providers/VideoProviders.dart';
import 'package:oole_app/screens/Jogador/Observadores.dart';
import 'package:oole_app/screens/Olheiro/Observados.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    var provider = Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.4), BlendMode.dstATop),
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1508098682722-e99c43a406b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.urlFotoPerfil == null
                      ? Constants.DEFAULT_USER_FOTO_PERFIL
                      : user.urlFotoPerfil),
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
                Navigator.of(context).pushNamed(AppRoutes.EDITAR_PERFIL);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text('Lista de observadores'),
              onTap: () {
                print("Tela de observadores");
                if (provider.userType == "Jogador") {
                  List list = user.observadores;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Observadores(list: list)),
                  );
                } else {
                  List list = user.observados;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => provider.userType == "Jogador"
                          ? Observadores(list: list)
                          : Observados(list: list),
                    ),
                  );
                }
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
                LoginService.logOut();
                Navigator.of(context).pushReplacementNamed(AppRoutes.INDEX);
                Provider.of<PerfilProvider>(context, listen: false)
                    .resetPerfil();
                Provider.of<VideoProvider>(context, listen: false).resetVideo();
                Provider.of<FeedProvider>(context, listen: false).resetFeed();
                // Provider.of<UserProvider>(context, listen: false).resetUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/models/Jogador.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  CustomBar(this.title);

  @override
  _CustomBarState createState() => _CustomBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _CustomBarState extends State<CustomBar> {
  final TextEditingController _loginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  _loadApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _tipo = prefs.getString("userType");

    if (_tipo == "Jogador") {
      await Provider.of<JogadorService>(context, listen: false)
          .loadCurrentUser();
    }
  }

  Widget _switchAppBar(BuildContext context) {
    if (widget.title == 'Procurar') {
      return AppBar(
        title: TextFormField(
          controller: _loginController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Procurar...",
            hintStyle: TextStyle(color: Colors.white54),
          ),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await Provider.of<JogadorService>(context, listen: false)
          .searchJogadores(_loginController.text);
            },
          ),
        ],
      );
    }

    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _switchAppBar(context);
  }
}

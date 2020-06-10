import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;


  CustomBar(this.title);

  @override
  _CustomBarState createState() => _CustomBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _CustomBarState extends State<CustomBar> {

  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  _loadApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _tipo = prefs.getString("userType");

    if (_tipo == "Jogador") {
      await Provider.of<JogadorService>(context, listen: false)
          .loadCurrentUser();
    }
  }

  @override
  Widget build(BuildContext context) {
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
}

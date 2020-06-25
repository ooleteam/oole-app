import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oole_app/main.dart';
import 'package:oole_app/providers/FeedProvider.dart';
import 'package:oole_app/providers/JogadorProvider.dart';
import 'package:oole_app/providers/OlheiroProvider.dart';
import 'package:oole_app/providers/PerfilProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/providers/VideoProviders.dart';
import 'package:oole_app/screens/Jogador/SearchJogador.dart';
import 'package:oole_app/screens/Olheiro/PlanoDePagamento.dart';
import 'package:oole_app/screens/Olheiro/SearchOlheiro.dart';
import 'package:oole_app/screens/Shared/EditarPerfil.dart';
import 'package:oole_app/screens/Jogador/PerfilUserJogador.dart';
import 'package:oole_app/screens/Olheiro/PerfilUserOlheiro.dart';
import 'package:oole_app/screens/Jogador/add_video.dart';
import 'package:oole_app/screens/home.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/CustomDrawer.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Jogador/HomeJogador.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;
  String _userType = "Jogador";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _screens = [
      {'title': 'Home', 'screen': Container()},
      {'title': 'Procurar', 'screen': Container()},
      {'title': 'Adicionar Video', 'screen': AddVideo()},
      {'title': 'Perfil', 'screen': Container()},
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loadtab();
    super.didChangeDependencies();
  }

  _loadtab() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userType = prefs.getString("userType");
    _screens = [
      {
        'title': 'Home',
        'screen': _userType == "Jogador" ? HomeJogador() : Home()
      },
      {
        'title': 'Procurar',
        'screen': _userType == "Jogador" ? SearchJogador() : SearchOlheiro()
      },
      {
        'title':
            _userType == "Jogador" ? "Adicionar Video" : "Cadastro de cartão",
        'screen': _userType == "Jogador" ? AddVideo() : PlanoDePagamento()
      },
      {
        'title': 'Perfil',
        'screen':
            _userType == "Jogador" ? PerfilUserJogador() : PerfilUserOlheiro()
      },
    ];
  }

  _cartaoOrVideo() {
    return _userType == "Jogador"
        ? BottomNavigationBarItem(
            icon: Icon(Icons.add_to_queue), title: Text('Adicionar Video'))
        : BottomNavigationBarItem(
            icon: Icon(Icons.credit_card), title: Text('Adicionar Cartão'));
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => JogadorProvider()),
        ChangeNotifierProvider(create: (_) => OlheiroProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PerfilProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomBar(_screens[_selectedScreenIndex] != null
              ? _screens[_selectedScreenIndex]['title']
              : ''),
          drawer: CustomDrawer(),
          body: _screens[_selectedScreenIndex]['screen'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectScreen,
            unselectedItemColor: Colors.grey[350],
            selectedItemColor: Colors.green,
            currentIndex: _selectedScreenIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Search')),
              _cartaoOrVideo(),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Perfil')),
            ],
          ),
        ),
        routes: {
          AppRoutes.INDEX: (ctx) => Index(),
          AppRoutes.EDITAR_PERFIL: (ctx) => EditarPerfil(),
          AppRoutes.OBSERVE: (ctx) => EditarPerfil()
        },
      ),
    );
  }
}

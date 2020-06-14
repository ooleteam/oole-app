import 'package:flutter/material.dart';
import 'package:oole_app/api/JogadorServices.dart';
import 'package:oole_app/api/VideosService.dart';
import 'package:oole_app/screens/add_video.dart';
import 'package:oole_app/screens/home.dart';
import 'package:oole_app/screens/perfil.dart';
import 'package:oole_app/screens/search.dart';
import 'package:oole_app/screens/search_user_perfil.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/CustomDrawer.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Home', 'screen': Home()},
      {'title': 'Procurar', 'screen': Search()},
      {'title': 'Adicionar Video', 'screen': AddVideo()},
      {'title': 'Perfil', 'screen': Perfil()},
    ];
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
        ChangeNotifierProvider(create: (_) => JogadorService()),
        ChangeNotifierProvider(create: (_) => VideoService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomBar(_screens[_selectedScreenIndex]['title']),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_to_queue),
                  title: Text('Adicionar Video')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Perfil')),
            ],
          ),
        ),
        routes: {
          AppRoutes.PERFIL: (ctx) => SearchUserPerfil()
        },
      ),
    );
  }
}

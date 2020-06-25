import 'package:flutter/material.dart';
import 'package:oole_app/screens/Intro/intro.dart';
import 'package:oole_app/screens/Intro/login.dart';
import 'package:oole_app/screens/Intro/register.dart';
import 'package:oole_app/screens/tabs.dart';
import 'package:oole_app/utils/app-routes.dart';
import 'package:flutter/services.dart';

// void main() => runApp(MaterialApp(home:Login()));
void main() => runApp(Index());

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[400],
        accentColor: Colors.white,
      ),
      routes: {
        AppRoutes.INTRO: (ctx) => Intro(),
        AppRoutes.LOGIN: (ctx) => Login(),
        AppRoutes.REGISTER: (ctx) => Register(),
        AppRoutes.TABS: (ctx) => TabsScreen(),
      },
    );
  }
}

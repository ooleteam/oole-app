import 'package:flutter/material.dart';
import 'package:oole_app/screens/intro.dart';
import 'package:oole_app/screens/login.dart';
import 'package:oole_app/utils/app-routes.dart';

void main() => runApp(MaterialApp(home: Index()));

class Index extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routes: {
        AppRoutes.INTRO: (ctx) => Intro(),
        AppRoutes.LOGIN: (ctx) => Login(),
      },
    );
  }

}
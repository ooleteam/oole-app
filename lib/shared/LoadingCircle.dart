import 'package:flutter/material.dart';

class LoadingCircle extends StatefulWidget {
  @override
  _LoadingCircleState createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]),
        semanticsLabel: "Aguarde...",
      ),
    );
  }
}
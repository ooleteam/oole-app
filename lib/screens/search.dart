import 'dart:async';

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isLoading = true;
  String _inputSearch = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Search"),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:path_provider/path_provider.dart';

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  // final _imageURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _titleFocusNode.dispose();
    _descFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(15),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: InkWell(
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                          )),
                          child: Center(
                            child: Icon(Icons.file_upload),
                          ),
                        ),
                        onTap: () {
                          // loadPathVideo();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Titulo",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: TextFormField(
                        maxLength: 100,
                        initialValue: _formData['title'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)),
                          fillColor: Colors.green[200],
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descFocusNode);
                        },
                        onSaved: (value) => _formData['title'] = value,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Informe um titulo válido';
                          }

                          if (value.trim().length < 3) {
                            return 'Informe um titulo com no minimo 3 letras';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Descrição",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          maxLines: 1000,
                          cursorColor: Colors.black,
                          initialValue: _formData['desc'],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.green[200],
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          focusNode: _descFocusNode,
                          keyboardType: TextInputType.multiline,
                          onSaved: (value) => _formData['desc'] = value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

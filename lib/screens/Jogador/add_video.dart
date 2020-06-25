import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/providers/VideoProviders.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  VideoPlayerController _controller;
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  bool _isStoring = false;
  bool _isUpLoading = false;
  var _video;

  _pickVideo() async {
    setState(() {
      _isUpLoading = true;
    });
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    _video = video;
    _controller = VideoPlayerController.file(_video)..initialize();
    setState(() {
      _isUpLoading = false;
    });
  }

  _save() async {
    _form.currentState.save();
    setState(() {
      _isStoring = true;
      _isLoading = true;
    });
    int userId = Provider.of<UserProvider>(context, listen: false).user.id;
    await Provider.of<VideoProvider>(context, listen: false)
        .createVideo(_video, _formData['title'], _formData['desc'], userId)
        .then((value) async {
      setState(() {
        _formData['title'] = '';
        _formData['desc'] = '';
        _isStoring = false;
        _isLoading = false;
      });

      if (value == '201') {
        return await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Cadastro concluido!"),
            content: Icon(Icons.check_circle),
          ),
        );
      }

      return await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Ocorreu um erro!"),
          content: Text("Ocorreu um erro durante o cadastro do produto!"),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleFocusNode.dispose();
    _descFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _isStoring
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Cadastrando Video..."),
                    SizedBox(
                      height: 30,
                    ),
                    LoadingCircle()
                  ],
                ),
              )
            : LoadingCircle()
        : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                          )),
                          child: _isUpLoading
                              ? VideoPlayer(_controller)
                              : Center(child: Icon(Icons.file_upload))),
                      onTap: () {
                        _pickVideo();
                      },
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
                          onFieldSubmitted: (_) {
                            _save();
                          },
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
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () {
                        _save();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

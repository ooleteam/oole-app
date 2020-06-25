import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/shared/AppBar.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  // final _imageURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  var user;
  File _image;

  @override
  void didChangeDependencies() {
    _load();
    super.didChangeDependencies();
  }

  _load() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    _formData['problemaSaude'] = user.problemaSaude == ''
        ? 'Nenhuma informação cadastrada'
        : user.problemaSaude;
    _formData['posicao'] = user.posicao;
    _formData['telefone'] = Formaters.telefoneFormmater(user.telefone);
  }

  Future<void> _saveForm() async {
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    Provider.of<UserProvider>(context).updateUser(_image, user);
  }

  _pickImageFromGallery() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = image;
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
    return Scaffold(
      appBar: CustomBar('Editar Perfil'),
      body: _isLoading
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
                      Row(
                        children: <Widget>[
                          InkWell(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(user == null
                                  ? Constants.DEFAULT_USER_FOTO_PERFIL
                                  : user.urlFotoPerfil),
                            ),
                            onTap: () {
                              _pickImageFromGallery();
                            },
                          ),
                          Spacer(flex: 1),
                          FlatButton(
                            child: Text('Save'),
                            onPressed: () {
                              _saveForm();
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Problema de Saúde",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            maxLines: 100000,
                            initialValue: _formData['problemaSaude'],
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
                              FocusScope.of(context)
                                  .requestFocus(_descFocusNode);
                            },
                            onSaved: (value) =>
                                _formData['problemaSaude'] = value,
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
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Posição",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextFormField(
                          maxLength: 100,
                          initialValue: _formData['posicao'],
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
                          onSaved: (value) => _formData['posicao'] = value,
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
                        "Telefone",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextFormField(
                          maxLength: 100,
                          initialValue: _formData['telefone'],
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
                          onSaved: (value) => _formData['telefone'] = value,
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

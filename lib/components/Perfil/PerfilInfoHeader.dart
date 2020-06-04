import 'package:flutter/material.dart';
import 'package:oole_app/utils/formaters.dart';

class PerfilInfoHeader extends StatefulWidget {
  final _user;

  PerfilInfoHeader(this._user);

  @override
  _PerfilInfoHeaderState createState() => _PerfilInfoHeaderState();
}

class _PerfilInfoHeaderState extends State<PerfilInfoHeader> {
  bool _expanded = false;
  bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Informações'),
                Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          if (_expanded)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Data de Nascimento: ' + widget._user.dataNascimento,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Sexo: ' + widget._user.sexo,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Estado de saúde: ' +
                        ((widget._user.problemaSaude == '' ||
                                widget._user.problemaSaude == null)
                            ? "Saúdavel"
                            : widget._user.problemaSaude),
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Email: '+widget._user.email,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Telefone: '+ Formaters.telefoneFormmater(widget._user.telefone),
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Endereço: ${widget._user.endereco}',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Bairro: ${widget._user.bairro} ',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Cidade: ${widget._user.cidade} / ${widget._user.estado}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

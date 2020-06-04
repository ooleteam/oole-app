import 'package:flutter/material.dart';

class PerfilMainHeader extends StatelessWidget {
  final String _url;
  final int _observadores;
  final int _seguidores;
  final int _seguindo;
  final String _nome;
  final String _posicao;

  PerfilMainHeader(this._url, this._observadores, this._seguidores,
      this._seguindo, this._nome, this._posicao);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        _url != null ? NetworkImage(_url) : Icon(Icons.person),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Text(_observadores.toString()),
                  Text("Observadores"),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(_seguidores.toString()),
                  Text("Seguidores"),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(_seguindo.toString()),
                  Text("Seguindo"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _nome,
            style: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold),
          ),
          Text(
            _posicao,
            style: TextStyle(color: Colors.green[400], fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

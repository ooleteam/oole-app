import 'package:oole_app/models/Jogador.dart';

class Olheiro {
  int id;
  String nome;
  String dataNascimento;
  String sexo;
  String login;
  String email;
  String telefone;
  String perfil;
  String nacionalidade;
  String cep;
  String bairro;
  String cidade;
  String estado;
  String endereco;
  String urlFotoPerfil;
  List<Jogador> observados;
  List<Olheiro> seguidores;
  List<Olheiro> seguindo;

  Olheiro(
      {this.id,
      this.nome,
      this.dataNascimento,
      this.sexo,
      this.login,
      this.email,
      this.telefone,
      this.perfil,
      this.nacionalidade,
      this.cep,
      this.bairro,
      this.cidade,
      this.estado,
      this.endereco,
      this.urlFotoPerfil,
      this.observados,
      this.seguidores,
      this.seguindo});

  Olheiro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataNascimento = json['dataNascimento'];
    sexo = json['sexo'];
    login = json['login'];
    email = json['email'];
    telefone = json['telefone'];
    perfil = json['perfil'];
    nacionalidade = json['nacionalidade'];
    cep = json['cep'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    endereco = json['endereco'];
    urlFotoPerfil = json['urlFotoPerfil'];
    if (json['observados'] != null) {
      observados = new List<Jogador>();
      json['observados'].forEach((v) {
        observados.add(new Jogador.fromJson(v));
      });
    }
    if (json['seguidores'] != null) {
      seguidores = new List<Olheiro>();
      json['seguidores'].forEach((v) {
        seguidores.add(new Olheiro.fromJson(v));
      });
    }
    if (json['seguindo'] != null) {
      seguindo = new List<Olheiro>();
      json['seguindo'].forEach((v) {
        seguindo.add(new Olheiro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['dataNascimento'] = this.dataNascimento;
    data['sexo'] = this.sexo;
    data['login'] = this.login;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['perfil'] = this.perfil;
    data['nacionalidade'] = this.nacionalidade;
    data['cep'] = this.cep;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['estado'] = this.estado;
    data['endereco'] = this.endereco;
    data['urlFotoPerfil'] = this.urlFotoPerfil;
    if (this.observados != null) {
      data['observados'] = this.observados.map((v) => v.toJson()).toList();
    }
    if (this.seguidores != null) {
      data['seguidores'] = this.seguidores.map((v) => v.toJson()).toList();
    }
    if (this.seguindo != null) {
      data['seguindo'] = this.seguindo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'package:oole_app/models/Olheiro.dart';
import 'package:oole_app/models/Video.dart';

class Jogador {
  int id;
  String nome;
  String dataNascimento;
  String urlFotoPerfil;
  String cpf;
  String sexo;
  String posicao;
  String problemaSaude;
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
  List<Video> videos;
  List<Jogador> seguidores;
  List<Jogador> seguindo;
  List<Olheiro> observadores;

  Jogador(
      {this.id,
      this.nome,
      this.dataNascimento,
      this.urlFotoPerfil,
      this.cpf,
      this.sexo,
      this.posicao,
      this.problemaSaude,
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
      this.videos,
      this.seguidores,
      this.seguindo,
      this.observadores});

  Jogador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataNascimento = json['dataNascimento'];
    urlFotoPerfil = json['urlFotoPerfil'];
    cpf = json['cpf'];
    sexo = json['sexo'];
    posicao = json['posicao'];
    problemaSaude = json['problemaSaude'];
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
    if (json['videos'] != null) {
      videos = new List<Video>();
      json['videos'].forEach((v) {
        videos.add(new Video.fromJson(v));
      });
    }
    if (json['observadores'] != null) {
      observadores = new List<Olheiro>();
      json['observadores'].forEach((v) {
        observadores.add(new Olheiro.fromJson(v));
      });
    }
    if (json['seguidores'] != null) {
      seguidores = new List<Jogador>();
      json['seguidores'].forEach((v) {
        seguidores.add(new Jogador.fromJson(v));
      });
    }
    if (json['seguindo'] != null) {
      seguindo = new List<Jogador>();
      json['seguindo'].forEach((v) {
        seguindo.add(new Jogador.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['dataNascimento'] = this.dataNascimento;
    data['urlFotoPerfil'] = this.urlFotoPerfil;
    data['cpf'] = this.cpf;
    data['sexo'] = this.sexo;
    data['posicao'] = this.posicao;
    data['problemaSaude'] = this.problemaSaude;
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
    if (this.observadores != null) {
      data['observadores'] = this.observadores.map((v) => v.toJson()).toList();
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
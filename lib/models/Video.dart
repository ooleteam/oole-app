import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Olheiro.dart';

class Video {
  int id;
  String title;
  String descricao;
  String url;
  String dataUpload;
  List<Jogador> jogadorLike;
  List<Jogador> jogadorDislike;
  List<Olheiro> olheiroLike;
  List<Olheiro> olheiroDislike;
  int totalLikes;
  int totalDislikes;

  Video(
      {this.id,
      this.title,
      this.descricao,
      this.url,
      this.dataUpload,
      this.jogadorLike,
      this.jogadorDislike,
      this.olheiroLike,
      this.olheiroDislike,
      this.totalLikes,
      this.totalDislikes});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descricao = json['descricao'];
    url = json['url'];
    dataUpload = json['dataUpload'];
    if (json['jogadorLike'] != null) {
      jogadorLike = new List<Jogador>();
      json['jogadorLike'].forEach((v) {
        jogadorLike.add(new Jogador.fromJson(v));
      });
    }
    if (json['jogadorDislike'] != null) {
      jogadorDislike = new List<Jogador>();
      json['jogadorDislike'].forEach((v) {
        jogadorDislike.add(new Jogador.fromJson(v));
      });
    }
    if (json['olheiroLike'] != null) {
      olheiroLike = new List<Olheiro>();
      json['olheiroLike'].forEach((v) {
        olheiroLike.add(new Olheiro.fromJson(v));
      });
    }
    if (json['olheiroDislike'] != null) {
      olheiroDislike = new List<Olheiro>();
      json['olheiroDislike'].forEach((v) {
        olheiroDislike.add(new Olheiro.fromJson(v));
      });
    }
    totalLikes = json['totalLikes'];
    totalDislikes = json['totalDislikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descricao'] = this.descricao;
    data['url'] = this.url;
    data['dataUpload'] = this.dataUpload;
    if (this.jogadorLike != null) {
      data['jogadorLike'] = this.jogadorLike.map((v) => v.toJson()).toList();
    }
    if (this.jogadorDislike != null) {
      data['jogadorDislike'] =
          this.jogadorDislike.map((v) => v.toJson()).toList();
    }
    if (this.olheiroLike != null) {
      data['olheiroLike'] = this.olheiroLike.map((v) => v.toJson()).toList();
    }
    if (this.olheiroDislike != null) {
      data['olheiroDislike'] =
          this.olheiroDislike.map((v) => v.toJson()).toList();
    }
    data['totalLikes'] = this.totalLikes;
    data['totalDislikes'] = this.totalDislikes;
    return data;
  }
}
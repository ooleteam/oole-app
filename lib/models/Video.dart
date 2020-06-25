import 'package:oole_app/models/Jogador.dart';
import 'package:oole_app/models/Olheiro.dart';

class Video {
  int id;
  String title;
  String descricao;
  String url;
  String dataUpload;
  List<Olheiro> like;
  Jogador jogador;
  int totalLikes;
  int totalDislikes;

  Video(
      {this.id,
      this.title,
      this.descricao,
      this.url,
      this.dataUpload,
      this.like,
      this.jogador,
      this.totalLikes,
      this.totalDislikes});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descricao = json['descricao'];
    url = json['url'];
    dataUpload = json['dataUpload'];
    if (json['likes'] != null) {
      like = new List<Olheiro>();
      json['likes'].forEach((v) {
        like.add(new Olheiro.fromJson(v));
      });
    }
    jogador = new Jogador.fromJson(json['jogador']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descricao'] = this.descricao;
    data['url'] = this.url;
    data['dataUpload'] = this.dataUpload;
    if (this.like != null) {
      data['likes'] = this.like.map((v) => v.toJson()).toList();
    }
    data['jogador'] = this.jogador.toJson();
    return data;
  }
}

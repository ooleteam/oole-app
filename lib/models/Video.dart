class Video {
  int id;
  String title;
  String descricao;
  String url;
  String dataUpload;
  int totalLike;
  int totaldislike;

  Video(
      {this.id,
      this.title,
      this.descricao,
      this.url,
      this.dataUpload,
      this.totalLike,
      this.totaldislike});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descricao = json['descricao'];
    url = json['url'];
    dataUpload = json['dataUpload'];
    totalLike = json['totalLike'];
    totaldislike = json['totaldislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descricao'] = this.descricao;
    data['url'] = this.url;
    data['dataUpload'] = this.dataUpload;
    data['totalLike'] = this.totalLike;
    data['totaldislike'] = this.totaldislike;
    return data;
  }
}

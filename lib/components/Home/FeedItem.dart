import 'package:flutter/material.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/screens/Shared/video_show.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:video_player/video_player.dart';

class FeedItem extends StatefulWidget {
  final Video _video;
  FeedItem(this._video);

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool _expanded = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget._video.url,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio * 0.9,
                    child: VideoPlayer(_controller),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoShow(widget._video),
                      ),
                    );
                  },
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget._video.jogador.urlFotoPerfil != null
                            ? widget._video.jogador.urlFotoPerfil
                            : Constants.DEFAULT_USER_FOTO_PERFIL,
                      ),
                    ),
                    title: Text(
                      widget._video.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[700],
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      widget._video.jogador.login,
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  ),
                ),
                _expanded
                    ? Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Criado em ' +
                                          Formaters.dataHoraFormatter(
                                            widget._video.dataUpload,
                                          ),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  Text(widget._video.descricao),
                                ],
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  height: 1,
                  color: Colors.green[200],
                  margin: EdgeInsets.only(bottom: 5),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

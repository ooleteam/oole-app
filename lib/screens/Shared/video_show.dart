import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oole_app/api/VideosService.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/providers/VideoProviders.dart';
import 'package:oole_app/utils/constants.dart';
import 'package:oole_app/utils/formaters.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoShow extends StatefulWidget {
  final Video _video;
  VideoShow(this._video);

  @override
  _VideoShowState createState() => _VideoShowState();
}

class _VideoShowState extends State<VideoShow> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool _likedByUser = false;

  @override
  void initState() {
    // _likedByUser = false;
    _controller = VideoPlayerController.network(
      widget._video.url,
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _load();
    super.didChangeDependencies();
  }

  _load() async {
    await Provider.of<VideoProvider>(context, listen: false)
        .loadVideo(widget._video)
        .then((value) {
      setState(() {
        _likedByUser =
            Provider.of<VideoProvider>(context, listen: false).isStarred;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typeUser = Provider.of<UserProvider>(context).userType;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        children: <Widget>[
                          VideoPlayer(_controller),
                          Center(
                            child: Icon(
                              _controller.value.isPlaying
                                  ? null
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  Container(
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
                      trailing: typeUser == "Olheiro"
                          ? IconButton(
                              icon:
                                  Provider.of<VideoProvider>(context).isStarred
                                      ? Icon(
                                          Icons.star,
                                          color: Colors.yellow[600],
                                        )
                                      : Icon(Icons.star_border),
                              onPressed: () async {
                                setState(() {
                                  _likedByUser = !_likedByUser;
                                });
                                await Provider.of<VideoProvider>(context,
                                        listen: false)
                                    .star(user);
                              },
                            )
                          : null,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                    margin: EdgeInsets.only(bottom: 5),
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

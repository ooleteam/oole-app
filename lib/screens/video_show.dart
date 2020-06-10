import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oole_app/models/Video.dart';
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
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget._video.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(widget._video.totalLike.toString()),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.thumb_up,
                                color: Colors.grey[400],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child:
                                  Text(widget._video.totaldislike.toString()),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.thumb_down,
                                color: Colors.grey[400],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   child: Text(widget._video.dataUpload),
                        // ),
                        Container(
                          child: Text(widget._video.descricao),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oole_app/components/VideoPlayer.dart';
import 'package:oole_app/models/Video.dart';

class PerfilBody extends StatefulWidget {
  final List<Video> videos;

  PerfilBody(this.videos);

  @override
  _PerfilBodyState createState() => _PerfilBodyState();
}

class _PerfilBodyState extends State<PerfilBody> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text(widget.videos[0].title),
    // );
    return Expanded(
      child: Container(
        width: double.infinity,
        child: GridView.builder(
          itemCount: widget.videos.length,
          itemBuilder: (BuildContext context, int index) {
            return VideoPlayerScreen(widget.videos[index]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
        ),
      ),
    );
  }
}

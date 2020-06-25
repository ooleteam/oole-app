import 'package:flutter/material.dart';
import 'package:oole_app/api/VideosService.dart';
import 'package:oole_app/components/Home/FeedItem.dart';
import 'package:oole_app/models/Video.dart';
import 'package:oole_app/providers/FeedProvider.dart';
import 'package:oole_app/providers/UserProvider.dart';
import 'package:oole_app/shared/LoadingCircle.dart';
import 'package:provider/provider.dart';

class HomeJogador extends StatefulWidget {
  @override
  _HomeJogadorState createState() => _HomeJogadorState();
}

class _HomeJogadorState extends State<HomeJogador> {
  List<Video> feedVideos;

  @override
  void initState() {
    feedVideos = Provider.of<FeedProvider>(context, listen: false).videoList;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loadFeed();
    super.didChangeDependencies();
  }

  Future<void> _loadFeed() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final provider = Provider.of<FeedProvider>(context, listen: false);
    // await provider.loadFeed(user.id).then((value) {
    //   setState(() {
    //     feedVideos = provider.videoList;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // feedVideos = Provider.of<FeedProvider>(context).videoList;
    return RefreshIndicator(
      onRefresh: () => _loadFeed(),
      child: feedVideos == null
          ? Center(child: LoadingCircle())
          : ListView.builder(
              itemCount: feedVideos.length,
              itemBuilder: (ctx, i) {
                return FeedItem(feedVideos[i]);
              },
            ),
    );
    // final user = Provider.of<UserProvider>(context).user;
    // return Center(
    //   child: Text(user.nome),
    // );
  }
}

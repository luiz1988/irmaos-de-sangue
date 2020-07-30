import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTeste extends StatefulWidget {
  @override
  _VideoTesteState createState() => _VideoTesteState();
}

class _VideoTesteState extends State<VideoTeste> {
  String id = "7QUtEmBT_-w";
  List<YoutubePlayerController> listController =
      new List<YoutubePlayerController>();

  getVideosUrl() async {
    var postsRef =
        await Firestore.instance.collection('/videos').getDocuments();
    var videoQtd = postsRef.documents.length;
    listController = new List<YoutubePlayerController>();
    for (var i = 0; i < videoQtd; i++) {
      listController.add(new YoutubePlayerController());
    }
    return postsRef;
  }

  List<Widget> printDocuments(snapshot) {
    return snapshot.data.documents
        .map((doc) => new ListTile(
              title: new Text(doc.data["link"]),
            ))
        .toList();
  }

  @override
  void deactivate() {
    // This pauses video while navigating to next page.
    for (var i = 0; i < listController.length; i++) {
      if (listController[i] != null) listController[i].pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    for (var i = 0; i < listController.length; i++) {
      listController[i].dispose();
    }
  }

  Widget _empresaCard(Map<String, dynamic> data, index) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: YoutubePlayer(
        context: context,
        videoId: YoutubePlayer.convertUrlToId(data["link"]),
        onPlayerInitialized: (controller) {
          listController[index] = controller;
        },
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          forceHideAnnotation: true,
          showVideoProgressIndicator: true,
          hideThumbnail: true,
          disableDragSeek: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVideosUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return _empresaCard(
                      snapshot.data.documents[index].data, index);
                });
          } else {
            return ListView(
              children: <Widget>[Text("Não há videos disponíveis!")],
            );
          }
        } else {
          return Center(
            child: Text("Não foi possível carregar os vídeos institucionais."),
          );
        }
      },
    );
  }
}

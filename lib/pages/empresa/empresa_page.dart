import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpresaPage extends StatefulWidget {
  @override
  _EmpresaPageState createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  Future<void> _getVideosUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("empresas")
              .orderBy('quatidadeLitro', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return _empresaCard(
                          snapshot.data.documents[index].data, index);
                    });
            }
          }),
    );
  }

  Widget _empresaCard(Map<String, dynamic> data, index) {
    var contador = index + 1;
    var card = Card(
      color: inserirCorBackGround(contador),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 30.0,
              height: 20.0,
              child: Text(contador.toString()),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(data["imageUrl"]), fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: 100.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data["nome"],
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data["nome"],
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 80.0),
                child: Container(
                  child: Text(
                    data["quatidadeLitro"].toString() + " L",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: inserirCorStar(contador),
              tooltip: 'Navigation menu',
              onPressed: null, // null disables the button
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      child: card,
      onTap: () {
        _getVideosUrl(data["empresaUrl"]);
      },
    );
  }

  Color inserirCorBackGround(contador) {
    if (contador == 1)
      return Colors.red[300];
    else if (contador == 2)
      return Colors.red[200];
    else if (contador == 3)
      return Colors.red[100];
    else if (contador > 3) return Colors.red[50];
  }

  Icon inserirCorStar(contador) {
    if (contador == 1)
      return Icon(Icons.star, color: Colors.yellow);
    else if (contador == 2)
      return Icon(Icons.star, color: Colors.grey);
    else if (contador == 3)
      return Icon(Icons.star, color: Colors.brown);
    else if (contador > 3) return Icon(Icons.star, color: Colors.grey[50]);
  }
}

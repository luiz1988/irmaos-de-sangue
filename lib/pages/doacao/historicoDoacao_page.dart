import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoricoDoacaopage extends StatefulWidget {
  @override
  _HistoricoDoacaopageState createState() => _HistoricoDoacaopageState();
}

class _HistoricoDoacaopageState extends State<HistoricoDoacaopage> {
  final UserRepository _userRepository = new UserRepository();
  var idUsuarioLogado;

  @override
  void initState() {
    getUserLogged();
  }

  Future<void> getUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      this.idUsuarioLogado = prefs.getString('idUsuario');
    });
  }

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
              .collection("/users")
              .document(idUsuarioLogado)
              .collection('donations').where('is_efetivado',isEqualTo: true)
              .orderBy('data_doacao', descending: true)
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
                      return _doacaoCard(
                          snapshot.data.documents[index].data, index);
                    });
            }
          }),
    );
  }

  Widget _doacaoCard(Map<String, dynamic> data, index) {
    var contador = index + 1;
    var card = Card(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            // Container(
            //   width: 30.0,
            //   height: 20.0,
            //   child: Text(contador.toString()),
            // ),
            Container(
              width: 70.0,
              height: 70.0,
              margin: EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(data["urlImage"]), fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data["nome"],
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data["data_doacao"],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text("Hemonúcleo"+ " - "+
                          data["cidade"],
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      child: card,
      onTap: () {
        _getVideosUrl(data["id_protocolo"]);
      },
    );
  }
}

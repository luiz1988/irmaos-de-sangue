import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irmaos_de_sangue/pages/quiz/quiz_page.dart';
import 'package:irmaos_de_sangue/pages/doacao/agendamento_page.dart';
import 'package:irmaos_de_sangue/pages/doacao/confirmacaoAgendamento.dart';
import 'package:irmaos_de_sangue/pages/doacao/historicoDoacao_page.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoacaoPage extends StatefulWidget {
  @override
  _DoacaoPageState createState() {
    return _DoacaoPageState();
  }
}

class _DoacaoPageState extends State<DoacaoPage> {
  bool isAgendado = false;
  String titulo;
  String mensagem;
  var hasDoacao;
  final UserRepository _userRepository = new UserRepository();
  @override
  void initState() {
    getUserLogged();
  }

  Future<void> recuperarDataAgendamento() async {
    var userUid = await _userRepository.getUserInfo();
    var doacao = await Firestore.instance
        .collection("/users")
        .document(userUid)
        .collection('donations')
        .getDocuments();
  }

  Future<void> getUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    var userUid = await _userRepository.getUserUid();
    prefs.setString('idUsuario', userUid);

    var arrayDoacao = await Firestore.instance
        .collection("/users")
        .document(userUid)
        .collection('donations').where('is_efetivado',isEqualTo: true)
        .getDocuments();

    setState(() {
      this.hasDoacao = arrayDoacao.documents.length;
    });
  }

  Future<void> sendEmail() async {
    String username = 'luiz-fernando1988@hotmail.com';
    String password = 'poliuretanico1';

    final smtpServer = hotmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add('luiz-fernando1988@hotmail.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // decoration: new BoxDecoration(color :Color.fromRGBO(223,225,230,0.89)),
      home: FutureBuilder(
          future: _userRepository.getUserInfo(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 130,
                            margin: EdgeInsets.only(top: 30),
                            width: 350,
                            child: snapshot.data != null &&
                                    snapshot.data["status"] == 1
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                    color: Colors.white,
                                    elevation: 10,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20.0, left: 20),
                                              child: Text('Doação',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23.0),
                                                  textAlign: TextAlign.left),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 17.0,
                                                  left: 20,
                                                  bottom: 10),
                                              child: RichText(
                                                text: new TextSpan(
                                                  style: new TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                  ),
                                                  children: <TextSpan>[
                                                    new TextSpan(
                                                      text:
                                                          '${snapshot.data['nome']}, ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                    new TextSpan(
                                                        text:
                                                            'faça sua triagem para',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0)),
                                                    new TextSpan(
                                                        text:
                                                            '\nver se está apto a doar sangue!',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : snapshot.data != null &&
                                        snapshot.data["status"] == 2
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        color: Colors.white,
                                        elevation: 10,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 20.0, left: 20),
                                                  child: Text('Agendamento',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 23.0),
                                                      textAlign:
                                                          TextAlign.left),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 17.0,
                                                      left: 20,
                                                      bottom: 10),
                                                  child: RichText(
                                                    text: new TextSpan(
                                                      style: new TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        new TextSpan(
                                                          text:
                                                              '${snapshot.data['nome']}, ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.0,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        ),
                                                        new TextSpan(
                                                            text:
                                                                'faça o agendamento da',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    20.0)),
                                                        new TextSpan(
                                                            text:
                                                                '\nsua doação!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    20.0)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : snapshot.data != null &&
                                            snapshot.data["status"] == 3
                                        ? Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                            ),
                                            color: Colors.white,
                                            elevation: 10,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20.0, left: 20),
                                                      child: Text('Confirmação',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 23.0),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 17.0,
                                                          left: 20,
                                                          bottom: 10),
                                                      child: RichText(
                                                        text: new TextSpan(
                                                          style: new TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.black,
                                                          ),
                                                          children: <TextSpan>[
                                                            new TextSpan(
                                                              text:
                                                                  '${snapshot.data['nome']},',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                            new TextSpan(
                                                              text:
                                                                  ' sua doação está',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                            new TextSpan(
                                                                text:
                                                                    '\nagendada para ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20.0)),
                                                            new TextSpan(
                                                                text: snapshot
                                                                        .data[
                                                                    "ultimo_agendamento"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueGrey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : snapshot.data != null &&
                                                snapshot.data["status"] == 4
                                            ? Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                ),
                                                color: Colors.white,
                                                elevation: 10,
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20.0,
                                                                  left: 20),
                                                          child: Text(
                                                              'Efetivação',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      23.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 17.0,
                                                                  left: 20,
                                                                  bottom: 10),
                                                          child: RichText(
                                                            text: new TextSpan(
                                                              style:
                                                                  new TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                new TextSpan(
                                                                  text:
                                                                      'Parabéns ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20.0),
                                                                ),
                                                                new TextSpan(
                                                                  text:
                                                                      '${snapshot.data['nome']} ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20.0,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic),
                                                                ),
                                                                new TextSpan(
                                                                  text:
                                                                      'pela sua',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20.0),
                                                                ),
                                                                new TextSpan(
                                                                    text:
                                                                        '\ndoação! doar sangue é ',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20.0)),
                                                                new TextSpan(
                                                                    text:
                                                                        'salvar vidas.',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20.0)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                ),
                                                color: Colors.white,
                                                elevation: 10,
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20.0,
                                                                  left: 20),
                                                          child: Text('Atenção',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      23.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 17.0,
                                                                  left: 20,
                                                                  bottom: 10),
                                                          child: RichText(
                                                            text: new TextSpan(
                                                              style:
                                                                  new TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                new TextSpan(
                                                                  text:
                                                                      '${snapshot.data['nome']} ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20.0,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic),
                                                                ),
                                                                new TextSpan(
                                                                    text:
                                                                        'dirija-se ao hemonúcleo',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20.0)),
                                                                new TextSpan(
                                                                    text:
                                                                        '\nmais próximo da sua localidadde!',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20.0)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                        //botões
                        Row(children: <Widget>[
                          Container(
                            width: 105,
                            height: 105,
                            margin: EdgeInsets.only(top: 40, left: 30),
                            child: snapshot.data != null &&
                                    snapshot.data["status"] == 1
                                ? Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    color: Colors.redAccent,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return SplashScreen();
                                            }),
                                          );
                                        },
                                        child: Center(
                                          child: Text("Doar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                        )))
                                : Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    color: Colors.red[100],
                                    child: InkWell(
                                        onTap: () {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(snapshot
                                                        .data["status"] ==
                                                    5
                                                ? 'Dirija-se ao hemonúcleo mais próximo da sua localidadde!'
                                                : snapshot.data["status"] == 2
                                                    ? 'Faça seu agendamento!'
                                                    : snapshot.data["status"] ==
                                                            3
                                                        ? 'Faça a efetivação da sua doação!'
                                                        : 'Após 90 dias faça seu próximo agendamento!'),
                                          ));
                                        },
                                        child: Center(
                                          child: Text("Doar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                        ))),
                          ),
                          Container(
                            width: 105,
                            height: 105,
                            margin: EdgeInsets.only(top: 40, left: 15),
                            child: snapshot.data != null &&
                                    snapshot.data["status"] == 2
                                ? Card(
                                    elevation: 10,
                                    color: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return AgendamentoPage();
                                            }),
                                          );
                                        },
                                        child: Center(
                                          child: Text("Agendar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                        )))
                                : Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    color: Colors.red[100],
                                    child: InkWell(
                                        onTap: () {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(snapshot
                                                        .data["status"] ==
                                                    5
                                                ? 'Dirija-se ao hemonúcleo mais próximo da sua localidadde!'
                                                : snapshot.data["status"] == 3
                                                    ? 'Faça a efetivação da sua doação!'
                                                    : snapshot.data["status"] ==
                                                            1
                                                        ? 'Verifique se você está apto a doar sangue!'
                                                        : 'Após 90 dias faça seu próximo agendamento!'),
                                          ));
                                        },
                                        child: Center(
                                          child: Text("Agendar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                        ))),
                          ),
                          Container(
                            width: 105,
                            height: 105,
                            margin: EdgeInsets.only(top: 40, left: 15),
                            child: snapshot.data != null &&
                                    snapshot.data["status"] == 3
                                ? Card(
                                    elevation: 10,
                                    color: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return ConfirmacaoAgendamento();
                                            }),
                                          );
                                        },
                                        child: Center(
                                          child: Text("Efetivar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                        )))
                                : Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    color: Colors.red[100],
                                    child: InkWell(
                                        onTap: () {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(snapshot
                                                        .data["status"] ==
                                                    5
                                                ? 'Dirija-se ao hemonúcleo mais próximo da sua localidadde!'
                                                : snapshot.data["status"] == 2
                                                    ? 'Faça seu agendamento!'
                                                    : snapshot.data["status"] ==
                                                            1
                                                        ? 'Verifique se você está apto a doar sangue!'
                                                        : 'Após 90 dias faça seu próximo agendamento!'),
                                          ));
                                        },
                                        child: Center(
                                          child: Text("Confirmar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0)),
                                        ))),
                          ),
                        ]),
                        Container(
                            width: 350,
                            height: 100,
                            margin: EdgeInsets.only(top: 60),
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.grey,
                                child: InkWell(
                                    onTap: () async {
                                      if (this.hasDoacao > 0) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return HistoricoDoacaopage();
                                          }),
                                        );
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'No momento você não possui nenhuma doação!'),
                                        ));
                                      }
                                    },
                                    child: Center(
                                      child: Text("Histórico das Doações",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0)),
                                    )))),
                      ],
                    ),
                  );
          }),
    );
  }
}

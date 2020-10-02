import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:irmaos_de_sangue/pages/doacao/doacao_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ConfirmacaoAgendamento extends StatefulWidget {
  ConfirmacaoAgendamento({Key key}) : super(key: key);

  @override
  _ConfirmacaoAgendamentoState createState() => _ConfirmacaoAgendamentoState();
}

final TextEditingController _nomeController = TextEditingController();
final TextEditingController _cidadeController = TextEditingController();
final TextEditingController _dataController = TextEditingController();
final TextEditingController _postoController = TextEditingController();
final TextEditingController _empresaController = TextEditingController();
final TextEditingController _tipoSanguineoController = TextEditingController();
final TextEditingController _quantidadeLitroController =
    TextEditingController();

final UserRepository _userRepository = new UserRepository();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ConfirmacaoAgendamentoState extends State<ConfirmacaoAgendamento> {
  final UserRepository _userRepository = new UserRepository();
  String userUid;
  String idUltimaDoacao;
  String idEmpresa;
  var quantidadeLitorAtual;
  bool isEnabled = false;
  bool isPressedCamera = false;
  void initState() {
    recuperarInformacoesAgendamento();
    recuperarIdUltimaDoacao();
  }

  Future<void> recuperarIdUltimaDoacao() async {
    var id = await _userRepository.getUserUid();
    var usuario = await _userRepository.getUserInfoDynamic();
    var empresa = await Firestore.instance
        .collection("/empresas")
        .document(usuario['companyId'])
        .get();

    setState(() {
      userUid = id;
      idUltimaDoacao = usuario['id_ultima_doacao'];
      idEmpresa = usuario['companyId'];
      quantidadeLitorAtual = empresa['quatidadeLitro'];
    });
  }

  Future<void> recuperarInformacoesAgendamento() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _cidadeController.text = prefs.getString('cidade');
      _postoController.text = prefs.getString('postoAtendimento');
      _dataController.text = prefs.getString('dataAgendamento');
      _nomeController.text = prefs.getString('nomeUsuario');
      _empresaController.text = prefs.getString('nomeEmpresa');
      _tipoSanguineoController.text = prefs.getString('tipoSanguineo');
      _quantidadeLitroController.text = "450 ml";
      // _postoController.text = "Av. da Saudade, 58 - centro";
    });
  }

  Future<void> removeDataFromPreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('cidade');
    prefs.remove('postoAtendimento');
    prefs.remove('dataAgendamento');
    prefs.remove('nomeUsuario');
    prefs.remove('nomeEmpresa');
    prefs.remove('tipoSanguineo');
  }

  Future<void> salvarProtocolo() async {
    File imgFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imgFile == null) return;
    setState(() {
      isPressedCamera = true;
    });
    StorageUploadTask task = FirebaseStorage.instance
        .ref()
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(imgFile);
    StorageTaskSnapshot snap = await task.onComplete;
    setState(() {
      isEnabled = true;
    });
    print(await snap.ref.getDownloadURL());
    atualizarAgendamento(await snap.ref.getDownloadURL());
    atualizarQuantidadeSangueEmpresa();
    atualizarStatusAgendamento();
  }

  Future<void> atualizarAgendamento(String idProtocol) async {
    // Example de como pegar valores de uma subcollection
    await Firestore.instance
        .collection("/users")
        .document(this.userUid)
        .collection('donations')
        .document(this.idUltimaDoacao)
        .updateData({'id_protocolo': idProtocol,'is_efetivado': true, 'urlImage':'https://firebasestorage.googleapis.com/v0/b/irmao-de-sangue.appspot.com/o/doe_sangue.jpg?alt=media&token=e68f85e9-a159-476b-9c53-4d987ba0690d'});
  }

  Future<void> atualizarQuantidadeSangueEmpresa() async {
    // Example de como pegar valores de uma subcollection
    int decimals = 2;
    int fac = pow(10, decimals);
    double d = this.quantidadeLitorAtual + 0.450;
    var quantidadeLitro = (d * fac).round() / fac;
    await Firestore.instance
        .collection("/empresas")
        .document(this.idEmpresa)
        .updateData({'quatidadeLitro': quantidadeLitro});
  }

  Future<void> atualizarStatusAgendamento() async {
    // Example de como pegar valores de uma subcollection
    await Firestore.instance
        .collection("/users")
        .document(userUid)
        .updateData({'status': 4});

    setState(() {
      isPressedCamera = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: _userRepository.getUserInfo(),
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Color.fromRGBO(234, 234, 234, 1),
              body: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 370,
                        height: 550,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text(
                                    'EFETIVE SUA DOAÇÃO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      decoration: TextDecoration.none,
                                    ),
                                  )),
                              Row(
                                children: <Widget>[
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 25),
                                      width: 160.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Nome:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _nomeController,
                                      )),
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 25),
                                      width: 120.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Cidade:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _cidadeController,
                                      )),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 25),
                                      width: 160.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Empresa:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _empresaController,
                                      )),
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 25),
                                      width: 120.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Data:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _dataController,
                                      )),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 30),
                                      width: 160.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Posto:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _postoController,
                                      )),
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 25),
                                      width: 120.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Volume:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          contentPadding:
                                              const EdgeInsets.only(top: 15.0),
                                        ),
                                        enabled: false,
                                        controller: _quantidadeLitroController,
                                      )),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 30, left: 11, right: 11),
                                  child: Text(
                                    'Para finalizar o processo de doação, faça o upload do atestado disponibilizado pelo hemonúcleo.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      decoration: TextDecoration.none,
                                    ),
                                  )),
                              Container(
                                child: IconButton(
                                    padding: new EdgeInsets.only(top: 15),
                                    icon: isPressedCamera ? Icon(Icons.check_circle,color:Colors.green , size: 50.0) : Icon(Icons.photo_camera, size: 50.0) ,
                                    onPressed: () {
                                      if (!isEnabled) {
                                        salvarProtocolo();
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Já foi feito o updload da imagem, faça sua efetivação!'),
                                        ));
                                      }
                                    }),
                              ),
                              Container(
                                  width: 330,
                                  height: 50,
                                  margin: EdgeInsets.only(top: 28),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: Color.fromRGBO(179, 20, 24, 1),
                                      child: InkWell(
                                          onTap: () async {
                                            if (isPressedCamera) {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Aguarde processamento do protocolo!',style: TextStyle(  fontSize: 17.0, ),),
                                              ));
                                            } else if (!isEnabled) {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Faça o upload do protocolo através câmera acima!',style: TextStyle(  fontSize: 16.0, ),),
                                              ));
                                            } else if (isEnabled) {
                                              removeDataFromPreference();
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DoacaoPage()),
                                              );
                                            }
                                          },
                                          child: Center(
                                            child: Text("Efetivar",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0)),
                                          )))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irmaos_de_sangue/pages/doacao/agendamento_page.dart';
import 'package:irmaos_de_sangue/pages/doacao/doacao_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

class ConfirmacaoPage extends StatefulWidget {
  @override
  _ConfirmacaoPageState createState() => _ConfirmacaoPageState();
}

class _ConfirmacaoPageState extends State<ConfirmacaoPage> {
  final UserRepository _userRepository = new UserRepository();

  Future<void> initState() {
    recuperarInformacoesAgendamento();
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
      // _postoController.text = "Av. da Saudade, 58 - centro";
    });
  }

  Future<void> removeInformationFromPreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('cidade');
    prefs.remove('postoAtendimento');
    prefs.remove('dataAgendamento');
    prefs.remove('nomeUsuario');
    prefs.remove('nomeEmpresa');
    prefs.remove('tipoSanguineo');
    // _postoController.text = "Av. da Saudade, 58 - centro"
  }

  Future<void> salvarInformacoesAgendamento() async {
    //Exemplo de como criar uma subcollection para um Id existente.
    var userUid = await _userRepository.getUserUid();
    final prefs = await SharedPreferences.getInstance();

    //Atualiza o status pra dar continuidade no fluxo de agendamento de doação
    await Firestore.instance
        .collection("/users")
        .document(userUid)
        .updateData({'status': 3});

    var doacao = {
      'cidade': _cidadeController.text,
      'posto_atendimento': _postoController.text,
      'data_doacao': _dataController.text,
      'nome': _nomeController.text,
      'nome_empresa': _empresaController.text,
      'tipo_sanguineo': _tipoSanguineoController.text,
      'is_efetivado': false
    };

    var document = await Firestore.instance
        .collection("/users")
        .document(userUid)
        .collection("donations");
    var idDoc = document.document().documentID;

    await Firestore.instance
        .collection("/users")
        .document(userUid)
        .collection("donations")
        .document(idDoc)
        .setData(doacao);

    await Firestore.instance
        .collection("/users")
        .document(userUid)
        .updateData({'id_ultima_doacao': idDoc});

    prefs.setString('idUltimaDoacao', idDoc);
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

  final TextEditingController _dateController = TextEditingController();
  GenericObject selectedCidade;
  List<GenericObject> cidades = new List<GenericObject>();
  GenericObject selectedPosto;
  List<GenericObject> postos = new List<GenericObject>();
  DateTime _date = new DateTime.now();
  String selectedDateFormatted;
  Future<Null> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _date) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      print('Date selected: ${formattedDate}');
      setState(() {
        _date = picked;
        selectedDateFormatted = formattedDate;
        controller.text = formattedDate;
      });
    }
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _postoController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _tipoSanguineoController =
      TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        height: 460,
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
                                    'CONFIRA ABAIXO OS DADOS DO RESPONSÁVEL PELO AGENDAMENTO ',
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
                                            fontSize: 15.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Nome:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
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
                                            fontSize: 15.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Cidade:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
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
                                            fontSize: 15.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Empresa:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
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
                                            fontSize: 15.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Data:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
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
                                      width: 180.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Posto:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _postoController,
                                      )),
                                  new Container(
                                      margin: EdgeInsets.only(top: 5, left: 25),
                                      width: 100.0,
                                      child: TextField(
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            height: 2.0,
                                            color: Colors.grey),
                                        decoration: InputDecoration(
                                          labelText: 'Tipo:',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          contentPadding:
                                              const EdgeInsets.only(top: 20.0),
                                        ),
                                        enabled: false,
                                        controller: _tipoSanguineoController,
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minWidth: 330.0,
                                  height: 50,
                                  color: Color.fromRGBO(179, 20, 24, 1),
                                  child: Text('Confirmar',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      )),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      salvarInformacoesAgendamento();
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DoacaoPage()),
                                      );
                                    }
                                  },
                                ),
                              ),
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:irmaos_de_sangue/pages/doacao/confirmacao_page.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendamentoPage extends StatefulWidget {
  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class GenericObject {
  const GenericObject(this.id, this.name);
  final String name;
  final String id;
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  void initState() {
    listarCidades();
    listarPostos();
    recuperarDadosPessoal();
  }

  final UserRepository _userRepository = new UserRepository();
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

  Future<void> recuperarDadosPessoal() async {
    final prefs = await SharedPreferences.getInstance();
    var usuario = await _userRepository.getUserInfoDynamic();
    String nomeUsuario = usuario['nome'];
    String tipoSanguineoId = usuario['tipoSanguineoId'];
    String empresaId = usuario['companyId'];

    var nomeEmpresa = await Firestore.instance
        .collection("/empresas")
        .document(empresaId)
        .get();
    var nomeTipoSanguineo = await Firestore.instance
        .collection("/sangues")
        .document(tipoSanguineoId)
        .get();

    String nomeEmpresaPref = nomeEmpresa.data['nome'];
    String tipoSanguineoPref = nomeTipoSanguineo.data['tipo_sanguineo'];

    prefs.setString('nomeEmpresa', nomeEmpresaPref);
    prefs.setString('tipoSanguineo', tipoSanguineoPref);
    prefs.setString('nomeUsuario', nomeUsuario);
  }

  void listarCidades() {
    List<GenericObject> listaCidades = new List<GenericObject>();
    listaCidades.add(new GenericObject('1', 'Araraquara-SP'));
    listaCidades.add(new GenericObject('2', 'São Carlos-SP'));
    listaCidades.add(new GenericObject('3', 'Matão-SP'));
    setState(() {
      cidades = listaCidades;
    });
  }

  void listarPostos() {
    List<GenericObject> listaPostos = new List<GenericObject>();
    listaPostos.add(new GenericObject('1', 'Hemonúcleo-Centro'));
    listaPostos.add(new GenericObject('2', 'Hemonúcleo-Centro'));
    listaPostos.add(new GenericObject('3', 'Hemonúcleo-Centro'));
    setState(() {
      postos = listaPostos;
    });
  }

  Future<void> salvarInformacoesAgendamento(String value, String chave) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(chave, value);
  }

  Future<void> atualizarDataDoacao() async {
    var userUid = await _userRepository.getUserUid();
    Firestore.instance
        .collection("/users")
        .document(userUid)
        .updateData({'ultimo_agendamento': selectedDateFormatted});
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _date1 = new TextEditingController();
  String selectedCity;
  String selectedPostoAtendimento;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(builder: (context, snapshot) {
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
                    height: 490,
                    // margin: EdgeInsets.only(top: 20),
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
                                'FAÇA SEU AGENDAMENTO ABAIXO',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                ),
                              )),
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 50, right: 50),
                            child: DropdownButtonFormField<String>(
                              value: selectedCity,
                              hint: Text(
                                'Informe o local',
                              ),
                              onChanged: (value) =>
                                  setState(() => selectedCity = value),
                              validator: (value) =>
                                  value == null ? 'Informe o local!' : null,
                              items: [
                                'Araraquara-SP',
                                'São Carlos-SP',
                                'Matão-SP'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 50, right: 50),
                            child: DropdownButtonFormField<String>(
                              value: selectedPostoAtendimento,
                              hint: Text(
                                'Informe o posto ',
                              ),
                              onChanged: (value) => setState(
                                  () => selectedPostoAtendimento = value),
                              validator: (value) =>
                                  value == null ? 'Informe o local!' : null,
                              items: [
                                'Hemonúcleo-Centro',
                                'Hemonúcleo-Matão',
                                'Hemonúcleo-São Carlos'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              new Container(
                                  margin: EdgeInsets.only(
                                      top: 35, left: 55, bottom: 20),
                                  width: 215.0,
                                  child: new TextFormField(
                                    textAlign: TextAlign.left,
                                    decoration: new InputDecoration(
                                        // suffixIcon:
                                        //     const Icon(Icons.calendar_today),
                                        hintText: 'Selecione uma data',
                                        hintStyle: TextStyle(fontSize: 17.0),
                                        fillColor: Colors.red),
                                    controller: _dateController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Selecione uma data!";
                                      }
                                    },
                                    readOnly: true,
                                    keyboardType: TextInputType.datetime,
                                  )),
                              new IconButton(
                                icon: const Icon(Icons.calendar_today),
                                tooltip: 'Escolha uma data',
                                onPressed: (() {
                                  _selectDate(context, _dateController);
                                }),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minWidth: 290.0,
                              height: 50,
                              color: Color.fromRGBO(179, 20, 24, 1),
                              child: Text('Agendar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  salvarInformacoesAgendamento(
                                      selectedCity, 'cidade');
                                  salvarInformacoesAgendamento(
                                      selectedPostoAtendimento, 'postoAtendimento');
                                  salvarInformacoesAgendamento(
                                      selectedDateFormatted, 'dataAgendamento');

                                  atualizarDataDoacao();

                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return ConfirmacaoPage();
                                    }),
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

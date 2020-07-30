import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrientationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Column(children: <Widget>[
          Text(
            "Orientações",
            style: TextStyle(
                color: Colors.red, fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
                "Antes de doar, certifique-se de que você atende às condições especificadas a seguir",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Requisitos Básicos",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Estar em boas condições de saúde",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Ter entre 16 e 69 anos, desde que a primeira doação tenha sido feita até 60 anos",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Pesar no mínimo 50kg (O Estado do Mato Grosso do Sul exige um mínimo de 55kg)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Estar descansado (ter dormido pelo menos 6 horas nas últimas 24 horas)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Estar alimentado (evitar alimentação gordurosa nas 4 horas que antecedem a doação). Se for pela manhã, fazer refeição leve, sem gorduras, como café, bolo, pão, cereais e frutas",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Apresentar documento original com foto, emitido por órgão oficial",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          " Estar com frequência cardíaca / pulso regulares, entre 50 e e 100 batimentos / pulsação por minuto",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Impedimento para Doação",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Febre, diarreia, gripe ou resfriado",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Ingestão de bebida alcóolica 12 horas antes da doação",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Gravidez",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Amamentação, se o parto ocorreu há menos de 12 meses",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Tatuagem/maquiagem definitiva nos últimos 12 meses",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Riscos de doenças sexualmente transmissíveis",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Exame endoscópico nos últimos 6 meses",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Malária, Hepatite, AIDS, Doença de Chagas",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          " Uso de drogas ilícitas injetáveis, uso de cocaína (últimos 12 meses). Uso de outras drogas será avaliado pelo triagista",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Diabetes tipos I e II ou insulinodependentes",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Intervalos entre doações",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.check_box,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Homens: 60 dias (máximo de 4 doações nos últimos 12 meses)",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.check_box,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Mulheres: 90 dias (máximo de 3 doações nos últimos 12 meses)",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text("MUITO IMPORTANTE: QUANDO FOR DOAR, SEJA SINCERO DURANTE A ENTREVISTA",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ]),
      ),
    );
  }
}

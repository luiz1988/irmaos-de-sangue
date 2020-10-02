import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:irmaos_de_sangue/pages/doacao/doacao_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _animateController;
  AnimationController _longPressController;
  AnimationController _secondStepController;
  AnimationController _thirdStepController;
  AnimationController _fourStepController;
  AnimationController _fithStepController;
  AnimationController _sixthStepController;
  AnimationController _seventhStepController;
  AnimationController _eigthStepController;
  AnimationController _ninethStepController;
  AnimationController _tenthStepController;

  double overall = 3.0;
  String overallStatus = "Bom";
  int curIndex = 0;
  String usingTimes = 'Daily';

  bool isFairly = false;
  bool isClear = false;
  bool isEasy = false;
  bool isFriendly = false;
  bool isApto = false;
  bool isNext = false;

  List<SecondQuestion> usingCollection = [
    SecondQuestion('sim', 'Sim'),
    SecondQuestion('nao', 'Não')
  ];

  Animation<double> longPressAnimation;
  Animation<double> secondTranformAnimation;
  Animation<double> thirdTranformAnimation;
  Animation<double> fourTranformAnimation;
  Animation<double> fithTranformAnimation;
  Animation<double> sixthTranformAnimation;
  Animation<double> seventhTranformAnimation;
  Animation<double> eigthTranformAnimation;
  Animation<double> ninethTranformAnimation;
  Animation<double> tenthTranformAnimation;

  final UserRepository _userRepository = new UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fithStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _sixthStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _seventhStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _eigthStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _ninethStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _tenthStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fourTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fourStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fithTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fithStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    sixthTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _sixthStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    seventhTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _seventhStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    eigthTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _eigthStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    ninethTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _ninethStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    tenthTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _tenthStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });

    _fithStepController.addListener(() {
      setState(() {});
    });

    _sixthStepController.addListener(() {
      setState(() {});
    });

    _seventhStepController.addListener(() {
      setState(() {});
    });

    _eigthStepController.addListener(() {
      setState(() {});
    });

    _ninethStepController.addListener(() {
      setState(() {});
    });

    _tenthStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
    _fourStepController.dispose();
    _fithStepController.dispose();
    _sixthStepController.dispose();
    _seventhStepController.dispose();
    _eigthStepController.dispose();
    _ninethStepController.dispose();
    _tenthStepController.dispose();
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startLongPressAnimation() async {
    try {
      await _longPressController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFourStepAnimation() async {
    try {
      await _fourStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFithStepAnimation() async {
    try {
      await _fithStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSixthStepAnimation() async {
    try {
      await _sixthStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSeventhStepAnimation() async {
    try {
      await _seventhStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startEigthStepAnimation() async {
    try {
      await _eigthStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startNinethStepAnimation() async {
    try {
      await _ninethStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startTenthStepAnimation() async {
    try {
      await _tenthStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future<void> salvarStatusPergunta(String value, String chave) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == "sim")
      prefs.setBool(chave, true);
    else
      prefs.setBool(chave, false);
  }

  readStatusPergunta(String chave) async {
    final prefs = await SharedPreferences.getInstance();
    final valor = prefs.getBool(chave);
    String questao = '$chave : $valor';
    print(questao);
  }

  Future<void> varificarSeEstaApto() async {
    final prefs = await SharedPreferences.getInstance();
    String questao = 'Question_';
    for (var i = 1; i < 10; i++) {
      questao += i.toString();
      final valor = prefs.getBool(questao);
      questao = questao.substring(0, 9);
      if (valor == null) {
        continue;
      } else if (valor) {
        setState(() {
          isApto = true;
        });
        break;
      }
    }
  }

  Future<void> removeDataFromPreference() async {
    final prefs = await SharedPreferences.getInstance();
    String questao = 'Question_';
    String chave;
    for (var i = 1; i < 10; i++) {
      chave = questao += i.toString();
      prefs.remove(chave);
      questao = questao.substring(0, 9);
    }
  }

  Future<void> salvarStatus(int status) async {
    // Example de como atualizar valores de um documento
    var userId = await _userRepository.getUserUid();
    await Firestore.instance
        .collection("/users")
        .document(userId)
        .updateData({'status': status});
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 16.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  if (!isNext) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Preecha umas das opção acima!',style: TextStyle(  fontSize: 20.0, ),),
                    ));
                  } else {
                    curIndex += 1;
                  }
                  setState(() async {
                    this.usingTimes = 'Daily';
                    if (curIndex == 1 && isNext) {
                      _startSecondStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 2 && isNext) {
                      _startThirdStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 3 && isNext) {
                      _startFourStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 4 && isNext) {
                      _startFithStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 5 && isNext) {
                      _startSixthStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 6 && isNext) {
                      _startSeventhStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 7 && isNext) {
                      _startEigthStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 8 && isNext) {
                      _startNinethStepAnimation();
                      isNext = !isNext;
                    } else if (curIndex == 9 && isNext) {
                      varificarSeEstaApto();
                      isNext = !isNext;
                      _startTenthStepAnimation();
                    } else if (curIndex == 10) {
                      isApto ? salvarStatus(5) : salvarStatus(2);
                      removeDataFromPreference();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoacaoPage()),
                      );
                    }
                  });
                },
                child: Center(
                    child: Text(
                  curIndex < 9 ? 'Continuar' : 'Finalizar',
                  style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                )),
              ),
            ))
          : null,
    );
  }

  //fim tela principal Widget stateful.

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
//                color: Colors.blue,
          margin: EdgeInsets.only(top: 30.0),
          height: 13.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(10, (int index) {
              return Container(
                decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                  color: index <= curIndex ? Colors.redAccent : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 13.0,
                width: (_width - 32.0 - 15.0) / 10.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 1.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? _getFirstStep()
            : curIndex == 1
                ? _getSecondStep()
                : curIndex == 2
                    ? _getThirdStep()
                    : curIndex == 3
                        ? _getFourStep()
                        : curIndex == 4
                            ? _getForthStep()
                            : curIndex == 5
                                ? _getSixthStep()
                                : curIndex == 6
                                    ? _getSeventhStep()
                                    : curIndex == 7
                                        ? _getEighthStep()
                                        : curIndex == 8
                                            ? _getNinthStep()
                                            : curIndex == 9
                                                ? _getLastStep()
                                                : _getLastStep()
      ],
    );
  }

  List<ThirdQuestion> firstQuestionList = [
    ThirdQuestion('Fairly cheaper price', false),
    ThirdQuestion('Clear tracking system', false),
    ThirdQuestion('Easy to use', false),
    ThirdQuestion('Friendly customer service', false),
  ];

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text('Questão 1',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0),
                  textAlign: TextAlign.center),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text(
                  'Recentemente nos últimos 7 dias, teve crise de asma ou bronquite leve(crises com intervalo maiores que 3 meses, compensada com medicamentos por via inalatória)?',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  textAlign: TextAlign.justify),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: 150.0,
                  child: Card(
                    child: Column(
                      children:
                          List.generate(usingCollection.length, (int index) {
                        final using = usingCollection[index];
                        return GestureDetector(
                          onTapUp: (detail) {
                            setState(() {
                              usingTimes = using.identifier;
                              isNext = !isNext;
                            });
                            salvarStatusPergunta(
                                using.identifier, 'Question_1');
                          },
                          child: Container(
                            height: 70.0,
                            color: usingTimes == using.identifier
                                ? Colors.orangeAccent.withAlpha(100)
                                : Colors.white,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                        activeColor: Colors.orangeAccent,
                                        value: using.identifier,
                                        groupValue: usingTimes,
                                        onChanged: (String value) {
                                          setState(() {
                                            isNext = !isNext;
                                            usingTimes = value;
                                          });
                                          salvarStatusPergunta(
                                              value, 'Question_1');
                                        }),
                                    Text(using.displayContent)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getSecondStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - secondTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: secondTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 2',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Para fazer a primeira doação de sangue é necessário ter a idade minima de 18 anos, você possui essa idade minima?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  usingTimes = using.identifier;
                                  isNext = !isNext;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_2');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                usingTimes = value;
                                                isNext = !isNext;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_2');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getThirdStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 3',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Idade máxima para se doar sangue conforme a legislação é entre 60 e 65 anos, voçê esta nessa faixa etária?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_3');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_3');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFourStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fourTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: fourTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 4',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Para poder fazer a doação é necessário ter no minimo 50 Kg, você possui um peso igual ou maior ao recomendado?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_4');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_4');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getForthStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fithTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: fithTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 5',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Você esta com a temperatura axiliar menor ou igual 37° C?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_5');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_5');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSixthStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - sixthTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: sixthTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 6',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Esta fazendo algum tratamento médico com remédio controlado?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_6');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_6');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSeventhStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - seventhTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: seventhTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 7',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Você teve febre, resfriado, dor de garganta ou gripe na última semana?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_7');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_7');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEighthStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - eigthTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: eigthTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 8',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Foi realizado algum tratamento odontológico nos últimos dias?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_8');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_8');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getNinthStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - ninethTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: ninethTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('Questão 9',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text(
                      'Foi realizado algum procedimento de tatuagem, piercing ou acupuntura nos últimos dias?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      textAlign: TextAlign.justify),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 150.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  isNext = !isNext;
                                  usingTimes = using.identifier;
                                });
                                salvarStatusPergunta(
                                    using.identifier, 'Question_9');
                              },
                              child: Container(
                                height: 70.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                isNext = !isNext;
                                                usingTimes = value;
                                              });
                                              salvarStatusPergunta(
                                                  value, 'Question_9');
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLastStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: isApto
                  ? Text(
                      'Você não está apto a doar sangue, por favor procure orientação do hemonúcleo da sua localidade!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'Você esta apto a doar sangue, por favor faça seu agendamento!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                      textAlign: TextAlign.center,
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Text(
                'No geral, como você classificaria nosso serviço?',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                overallStatus,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Slider(
                  value: overall,
                  onChanged: (value) {
                    setState(() {
                      isNext = !isNext;
                      overall = value.round().toDouble();
                      _getOverallStatus(overall);
                    });
                  },
                  label: '${overall.toInt()}',
                  divisions: 30,
                  min: 1.0,
                  max: 5.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        overallStatus = 'Ruim';
        break;
      case 2:
        overallStatus = 'Normal';
        break;
      case 3:
        overallStatus = 'Bom';
        break;
      case 4:
        overallStatus = 'Muito bom';
        break;
      default:
        overallStatus = 'Excelente';
        break;
    }
  }
}

// Fim widget statefull

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key key, this.controller, this.screenWidth, this.onStartAnimation})
      : width = Tween<double>(
          begin: screenWidth,
          end: 40.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(2.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 4,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 3.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
//                color: Colors.blue,
                    margin: EdgeInsets.only(top: 30.0),
                    height: 13.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                            color: index == 0 ? Colors.redAccent : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 13.0,
                          width: (screenWidth - 15.0) / 10.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 1.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
//                color: Colors.blue,
                      margin: EdgeInsets.only(top: 34.0),
//                height: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child:
                          Center(child: Image.asset('assets/doar_vida.png'))),
                  Text(
                    'Responda o questionário em 3 minutos.',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                    child: Text(
                      'Ao responder a esse questionário de 3 minutos, você nos ajuda identificar se voçê esta apto ou não a doar sangue',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value,
                    child: GestureDetector(
                      child: Container(
                        height: height.value,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: radius.value),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Responda o Questonário',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SecondQuestion {
  final String identifier;
  final String displayContent;

  SecondQuestion(this.identifier, this.displayContent);
}

class ThirdQuestion {
  final String displayContent;
  bool isSelected;

  ThirdQuestion(this.displayContent, this.isSelected);
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irmaos_de_sangue/authentication_bloc/bloc.dart';
import 'package:irmaos_de_sangue/pages/register/bloc/bloc.dart';
import 'package:irmaos_de_sangue/pages/register/register_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class GenericObject {
  const GenericObject(this.id, this.name);
  final String name;
  final String id;
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  final TextEditingController _dateDonationController = TextEditingController();

  int currStep = 0;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _weightController.text.isNotEmpty &&
      _dateBirthController.text.isNotEmpty &&
      _dateDonationController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  GenericObject selectedCompany;
  List<GenericObject> companies = new List<GenericObject>();

  GenericObject selectedSexo;
  List<GenericObject> generos = new List<GenericObject>();

  GenericObject selectedEstadoCivil;
  List<GenericObject> situacoes = new List<GenericObject>();

  GenericObject selectedTipoSanguineo;
  List<GenericObject> tiposSangues = new List<GenericObject>();

  GenericObject selectedEstado;
  List<GenericObject> estados = new List<GenericObject>();

  GenericObject selectedCidade;
  List<GenericObject> cidades = new List<GenericObject>();

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _nameController.addListener(_onNameChanged);
    _phoneNumberController.addListener(_onNumberPhoneChanged);
    _weightController.addListener(_onWeightChanged);
    _dateBirthController.addListener(_onDateBirthChanged);
    _dateDonationController.addListener(_onDateDonationChanged);

    getEmpresas();
    getGeneros();
    getStadoCivil();
    getTipoSanguineo();
    getEstados();
    getCidades();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          List<Step> steps = [
            new Step(
              title: const Text('Seu nome completo*'),
              isActive: true,
              state: StepState.indexed,
              content: new TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                autocorrect: true,
                autovalidate: true,
                maxLines: 1,
                validator: (_) {
                  return !state.isNameValid ? 'Nome Inválido' : null;
                },
                decoration: new InputDecoration(
                    labelText: 'Informe seu nome',
                    hintText: 'Informe seu nome',
                    icon: const Icon(Icons.person),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
            ),
            new Step(
              title: const Text('Seu e-mail*'),
              isActive: true,
              state: StepState.indexed,
              content: new TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: true,
                autovalidate: true,
                validator: (_) {
                  return !state.isEmailValid ? 'Email Inválido' : null;
                },
                maxLines: 1,
                decoration: new InputDecoration(
                    labelText: 'Informe seu e-mail',
                    hintText: 'Informe seu e-mail',
                    icon: const Icon(Icons.email),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
            ),
            new Step(
              title: const Text('Senha para acesso*'),
              isActive: true,
              state: StepState.indexed,
              content: new TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: true,
                autovalidate: true,
                validator: (_) {
                  return !state.isPasswordValid ? 'Senha Inválido' : null;
                },
                maxLines: 1,
                decoration: new InputDecoration(
                    labelText: 'Informe sua senha',
                    hintText: 'Informe sua senha',
                    icon: const Icon(Icons.lock),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
            ),
            new Step(
                title: Text("Empresa*"),
                content: FormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Selecione Empresa";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    //formData['town'] = value;
                  },
                  autovalidate: true,
                  builder: (
                    FormFieldState<String> state,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: new Text("Selecione Empresa"),
                              value: selectedCompany,
                              onChanged: (GenericObject newValue) {
                                state.didChange(newValue.name);
                                setState(() {
                                  selectedCompany = newValue;
                                });
                              },
                              items: companies.map((GenericObject company) {
                                return new DropdownMenuItem<GenericObject>(
                                  value: company,
                                  child: Text(
                                    company.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          state.hasError ? state.errorText : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
                isActive: true),
            new Step(
              title: const Text('Número celular*'),
              isActive: true,
              state: StepState.indexed,
              content: new TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                autovalidate: true,
                maxLines: 1,
                validator: (_) {
                  return !state.isPhoneNumber ? 'Número Inválido' : null;
                },
                decoration: new InputDecoration(
                    labelText: 'Informe seu número celular',
                    hintText: 'Informe seu número celular',
                    icon: const Icon(Icons.person),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
            ),
            new Step(
                title: Text("Sexo*"),
                content: FormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Selecione Sexo";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    //formData['town'] = value;
                  },
                  autovalidate: true,
                  builder: (
                    FormFieldState<String> state,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: new Text("Selecione Sexo"),
                              value: selectedSexo,
                              onChanged: (GenericObject newValue) {
                                state.didChange(newValue.name);
                                setState(() {
                                  selectedSexo = newValue;
                                });
                              },
                              items: generos.map((GenericObject genero) {
                                return new DropdownMenuItem<GenericObject>(
                                  value: genero,
                                  child: Text(
                                    genero.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          state.hasError ? state.errorText : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
                isActive: true),
            new Step(
              title: const Text('Peso*'),
              isActive: true,
              state: StepState.indexed,
              content: new TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                autovalidate: true,
                maxLines: 1,
                validator: (_) {
                  return !state.isWeight ? 'Peso Inválido' : null;
                },
                decoration: new InputDecoration(
                    labelText: 'Informe seu peso',
                    hintText: 'Informe seu peso',
                    icon: const Icon(Icons.person),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
            ),
            new Step(
                title: Text("Estado civil*"),
                content: FormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Selecione Estado Civil";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    //formData['town'] = value;
                  },
                  autovalidate: true,
                  builder: (
                    FormFieldState<String> state,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: new Text("Selecione Estado Civil"),
                              value: selectedEstadoCivil,
                              onChanged: (GenericObject newValue) {
                                state.didChange(newValue.name);
                                setState(() {
                                  selectedEstadoCivil = newValue;
                                });
                              },
                              items: situacoes.map((GenericObject situacao) {
                                return new DropdownMenuItem<GenericObject>(
                                  value: situacao,
                                  child: Text(
                                    situacao.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          state.hasError ? state.errorText : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
                isActive: true),
            new Step(
              title: const Text('Data nascimento*'),
              isActive: true,
              state: StepState.indexed,
              content: Row(children: <Widget>[
                new Expanded(
                    child: new TextFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    hintText: 'Escolha uma data',
                  ),
                  readOnly: true,
                  validator: (_) {
                    return !state.isDateBirth ? 'Data Inválida' : null;
                  },
                  controller: _dateBirthController,
                  keyboardType: TextInputType.datetime,
                )),
                new IconButton(
                  icon: new Icon(Icons.more_horiz),
                  tooltip: 'Escolha uma data',
                  onPressed: (() {
                    _chooseDate(context, _dateBirthController.text,
                        _dateBirthController);
                  }),
                )
              ]),
            ),
            new Step(
                title: Text("Informe seu tipo Sanguineo*"),
                content: FormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Selecione Tipo Sanguineo";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    //formData['town'] = value;
                  },
                  autovalidate: true,
                  builder: (
                    FormFieldState<String> state,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: new Text("Selecione Tipo Sanguineo"),
                              value: selectedTipoSanguineo,
                              onChanged: (GenericObject newValue) {
                                state.didChange(newValue.name);
                                setState(() {
                                  selectedTipoSanguineo = newValue;
                                });
                              },
                              items: tiposSangues.map((GenericObject sangue) {
                                return new DropdownMenuItem<GenericObject>(
                                  value: sangue,
                                  child: Text(
                                    sangue.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          state.hasError ? state.errorText : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
                isActive: true),
            new Step(
              title: const Text('Data da última doação'),
              isActive: true,
              state: StepState.indexed,
              content: Row(children: <Widget>[
                new Expanded(
                    child: new TextFormField(
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    hintText: 'Escolha uma data',
                  ),
                  readOnly: true,
                  controller: _dateDonationController,
                  keyboardType: TextInputType.datetime,
                )),
                new IconButton(
                  icon: new Icon(Icons.more_horiz),
                  tooltip: 'Escolha uma data',
                  onPressed: (() {
                    _chooseDate(context, _dateDonationController.text,
                        _dateDonationController);
                  }),
                )
              ]),
            ),
            new Step(
                title: Text("Estado onde mora*"),
                content: FormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Selecione Estado";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    //formData['town'] = value;
                  },
                  autovalidate: true,
                  builder: (
                    FormFieldState<String> state,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: new Text("Selecione Estado"),
                              value: selectedEstado,
                              onChanged: (GenericObject newValue) {
                                state.didChange(newValue.name);
                                setState(() {
                                  selectedEstado = newValue;
                                });
                              },
                              items: estados.map((GenericObject estado) {
                                return new DropdownMenuItem<GenericObject>(
                                  value: estado,
                                  child: Text(
                                    estado.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          state.hasError ? state.errorText : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
                isActive: true),
            new Step(
                title: Text("Cidade onde mora*"),
                content: FormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Selecione Cidade";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    //formData['town'] = value;
                  },
                  autovalidate: true,
                  builder: (
                    FormFieldState<String> state,
                  ) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: new Text("Selecione Cidade"),
                              value: selectedCidade,
                              onChanged: (GenericObject newValue) {
                                state.didChange(newValue.name);
                                setState(() {
                                  selectedCidade = newValue;
                                });
                              },
                              items: cidades.map((GenericObject cidade) {
                                return new DropdownMenuItem<GenericObject>(
                                  value: cidade,
                                  child: Text(
                                    cidade.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          state.hasError ? state.errorText : '',
                          style: TextStyle(
                              color: Colors.redAccent.shade700, fontSize: 12.0),
                        ),
                      ],
                    );
                  },
                ),
                isActive: true),
          ];

          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(children: <Widget>[
                Hero(
                  tag: 'hero',
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 48.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Theme(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: 400.0),
                    child: new Stepper(
                      steps: steps,
                      type: StepperType.vertical,
                      currentStep: this.currStep,
                      onStepContinue: () {
                        setState(
                          () {
                            if (currStep < steps.length - 1) {
                              currStep = currStep + 1;
                            } else {
                              currStep = 0;
                            }
                          },
                        );
                      },
                      onStepCancel: () {
                        setState(() {
                          if (currStep > 0) {
                            currStep = currStep - 1;
                          } else {
                            currStep = 0;
                          }
                        });
                      },
                      onStepTapped: (step) {
                        setState(() {
                          currStep = step;
                        });
                      },
                    ),
                  ),
                  data: ThemeData(primaryColor: Colors.red),
                ),
                RegisterButton(onPressed: () => _onFormSubmitted(state)),
              ]),
            ),
          );
        },
      ),
    );
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  Future _chooseDate(BuildContext context, String initialDateString,
      TextEditingController controller) async {
    final f = new DateFormat('dd/MM/yyyy');
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2060));

    if (result == null) return;

    setState(() {
      controller.text = f.format(result);
    });
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  void _onNameChanged() {
    _registerBloc.dispatch(
      NameChanged(name: _nameController.text),
    );
  }
  void _onEmailChanged() {
    _registerBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onNumberPhoneChanged() {
    _registerBloc.dispatch(
      PhoneNumberChanged(phoneNumber: _phoneNumberController.text),
    );
  }

  void _onWeightChanged() {
    _registerBloc.dispatch(
      WeightChanged(weight: _weightController.text),
    );
  }

  void _onDateBirthChanged() {
    _registerBloc.dispatch(
      DateBirthChanged(dateBirth: _dateBirthController.text),
    );
  }

  void _onDateDonationChanged() {
    _registerBloc.dispatch(
      DateDonationChanged(dateDonation: _dateDonationController.text),
    );
  }

  void _onFormSubmitted(RegisterState state) {
    if (state.isFormValid) {
      _registerBloc.dispatch(
        Submitted(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          companyId: selectedCompany.id,
          numeroCelular: _phoneNumberController.text,
          sexoId: selectedSexo.id,
          peso: _weightController.text,
          estadoCivilId: selectedEstadoCivil.id,
          dataNascimento: _dateBirthController.text,
          tipoSanguineoId: selectedTipoSanguineo.id,
          dataDoacao: _dateDonationController.text,
          estadoId: selectedEstado.id,
          cidadeId: selectedCidade.id,
          photoUrl:
              "https://lh3.googleGenericObjectcontent.com/-6XnV92p4vLE/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rfL-UDEUeZhid0cCkRv6cPScs1Cpg.CMID/s400-c/photo.jpg",
        ),
      );
    }
  }

  void getEmpresas() async {
    var data = await Firestore.instance.collection('/empresas').getDocuments();
    List<GenericObject> listEmpresa = new List<GenericObject>();
    data.documents
        .map((x) =>
            {listEmpresa.add(new GenericObject(x.documentID, x.data["nome"]))})
        .toList();

    setState(() {
      companies = listEmpresa;
    });
  }

  void getGeneros() async {
    var data = await Firestore.instance.collection('/generos').getDocuments();
    List<GenericObject> listaGeneros = new List<GenericObject>();
    data.documents
        .map((x) =>
            {listaGeneros.add(new GenericObject(x.documentID, x.data["tipo"]))})
        .toList();

    setState(() {
      generos = listaGeneros;
    });
  }

  void getStadoCivil() async {
    var data = await Firestore.instance.collection('/situacoes').getDocuments();
    List<GenericObject> listaSituacoes = new List<GenericObject>();
    data.documents
        .map((x) => {
              listaSituacoes.add(
                  new GenericObject(x.documentID, x.data["situacao_civil"]))
            })
        .toList();

    setState(() {
      situacoes = listaSituacoes;
    });
  }

  void getTipoSanguineo() async {
    var data = await Firestore.instance.collection('/sangues').getDocuments();
    List<GenericObject> listaSangues = new List<GenericObject>();
    data.documents
        .map((x) => {
              listaSangues.add(
                  new GenericObject(x.documentID, x.data["tipo_sanguineo"]))
            })
        .toList();

    setState(() {
      tiposSangues = listaSangues;
    });
  }

  void getEstados() async {
    var data = await Firestore.instance.collection('/estados').getDocuments();
    List<GenericObject> listaEstados = new List<GenericObject>();
    data.documents
        .map((x) =>
            {listaEstados.add(new GenericObject(x.documentID, x.data["nome"]))})
        .toList();

    setState(() {
      estados = listaEstados;
    });
  }

  void getCidades() async {
    var data = await Firestore.instance.collection('/cidades').getDocuments();
    List<GenericObject> listaCidades = new List<GenericObject>();
    data.documents
        .map((x) =>
            {listaCidades.add(new GenericObject(x.documentID, x.data["nome"]))})
        .toList();

    setState(() {
      cidades = listaCidades;
    });
  }
}

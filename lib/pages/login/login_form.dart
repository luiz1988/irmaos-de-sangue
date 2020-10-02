import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irmaos_de_sangue/authentication_bloc/bloc.dart';
import 'package:irmaos_de_sangue/pages/home/home_page.dart';
import 'package:irmaos_de_sangue/pages/login/create_account_button.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';

import 'bloc/bloc.dart';
import 'bloc/login_event.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return HomePage(
              userRepository: _userRepository,
            );
          }));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Form(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.asset('assets/logo.png'),
                    ),
                    TextFormField(
                      style:TextStyle(  fontSize: 20.0, ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        labelText: 'Email',
                         labelStyle: TextStyle(
                          fontSize: 20),
                      ),
                      autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffix: showPassword(),
                        labelText: 'Password',
                         labelStyle: TextStyle(
                          fontSize: 20),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      obscureText: _obscureText,
                      autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    LoginButton(
                      onPressed: () => _onFormSubmitted(state)                        
                    ),
                    CreateAccountButton(userRepository: _userRepository),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showPassword() {
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.down,
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(
        _obscureText ? Icons.visibility : Icons.visibility_off,
        semanticLabel: _obscureText ? 'show password' : 'hide password',
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted(LoginState state) {
    if (state.isFormValid) {
      _loginBloc.dispatch(
        LoginWithCredentialsPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
